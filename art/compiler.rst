Compiler Optimization
###############################################################################

ARTには、いくつかのコンパイラや中間言語が定義されており、いろいろと実験しているようだ。
その一覧と最適化を抽出してみる。

コンパイラは、quickとportable
portableが、llvmを使う奴。
quickは自前実装。dalvikから持ってきてmethod compile向けに改造したと見てよい。

IRは、 MIR/LIRが定義されている。

コンパイラ群は、大まかにはfrontend/backendに分かれていると見てよい。
ARTのコンパイラのfrontendは、dexをART MIRに変換して各種最適化を行う。
その後backendの入力であるLIRを生成する。

backendはLIRをさらに最適化して、LIRからアセンブラコードを生成する。
ただし、quickはquick LIRに変換ののち、x86/arm/mipsのアセンブラを生成する。
portableのLIR == Bitcodeである。


Runtime
*******************************************************************************

backendは今のところ2種類きりかえられるようになっている。
art/runtimeからの制御はそうなっている。

CompilerBackend compiler_backend = kPortable;
CompilerBackend compiler_backend = kQuick;

コンパイルパイプラインの大枠
*******************************************************************************

コンパイルジョブは以下

ArtCompileMethod()
ArtQuickCompileMethod()
ArtCompileDEX()
SeaIrCompileMethod()

入力はDexFileになっている。


backendを複数切り替えることができる。

art/dex
*******************************************************************************

dexからのフロントエンドとMIRを定義している。

CompileMethod()が起点かな。

backendごとに最適化を切り替えている。

portableの場合
// Fused long branches not currently usseful in bitcode.
// これはLocalValueNumberingにおいて、compareの最適化っぽい。
kBranchFusing,

quickの場合、

kLoadStoreElimination = 0,
kLoadHoisting,
kSuppressLoads,
kNullCheckElimination,
kPromoteRegs,
kTrackLiveTemps,
kSafeOptimizations, //RemoveRedundantBranches
kBBOpt,  //未実装。何もない。
kMatch,  //MIRの最適化
kPromoteCompilerTemps,  //MIRの最適化


MIRの最適化
SSAに変換したのち、

constant propagation
null check elimination
Combine basic blocks
local value numbering



基本的なコンパイルの流れ  ::

  //ここはコンストラクタ呼び出しのみ
  cu.mir_graph.reset(new MIRGraph(&cu, &cu.arena));

  /* Build the raw MIR graph */
  cu.mir_graph->InlineMethod(code_item, access_flags, invoke_type, class_def_idx, method_idx,
                             class_loader, dex_file);
  // ここでMIRへの変換を行う。inliningは未実装。
  // BB単位でひたすらMIR変換。BBのCFGを生成する。trycatchのブロックにも対応
  // dataflow attributeの設定


  /* Do a code layout pass */
  cu.mir_graph->CodeLayout();
  // CFGをwalkしながら、fallthrowを綺麗にするだけかな。

  /* Perform SSA transformation for the whole method */
  cu.mir_graph->SSATransformation();
      /* Compute the DFS order */
      ComputeDFSOrders();

      /* Compute the dominator info */
      ComputeDominators();

      /* Allocate data structures in preparation for SSA conversion */
      CompilerInitializeSSAConversion();

      /* Find out the "Dalvik reg def x block" relation */
      ComputeDefBlockMatrix();

      /* Insert phi nodes to dominance frontiers for all variables */
      InsertPhiNodes();

      /* Rename register names by local defs and phi nodes */
      ClearAllVisitedFlags();
      DoDFSPreOrderSSARename(GetEntryBlock());

      /*
       * Shared temp bit vector used by each block to count the number of defs
       * from all the predecessor blocks.
       */
      temp_ssa_register_v_ =
      new (arena_) ArenaBitVector(arena_, GetNumSSARegs(), false, kBitMapTempSSARegisterV);

      //ループで回りながら
      InsertPhiNodeOperands(bb)
      ...

  /* Do constant propagation */
  cu.mir_graph->PropagateConstants();
  // 一般的な定数伝搬

  /* Count uses */
  cu.mir_graph->MethodUseCount();
  // SSARegsをresizeする。phinodeの個数やoperandを調整

  /* Perform null check elimination */
  cu.mir_graph->NullCheckElimination();

  /* Combine basic blocks where possible */
  cu.mir_graph->BasicBlockCombine();
  // BBが連続する場合、単純なfall throughなケースにおいてBBを融合する。

  /* Do some basic block optimizations */
  cu.mir_graph->BasicBlockOptimization();
  // BB単位のLocalValueNumbering
  // BBを超えるケースでもがんばるが、ループでは伝搬を中止する。
  // ifやswitchのケースでは、BBを越えて伝搬させる。
  // joinブロック(predが複数の、phiで値を融合するケース)での融合も行うっぽい。

  /* Set up regLocation[] array to describe values - one for each ssa_name. */
  cu.mir_graph->BuildRegLocations();
  // 簡単なレジスタ割付まで行うらしい。

その後 ::

  if (compiler_backend == kPortable) {
    cu.cg.reset(PortableCodeGenerator(&cu, cu.mir_graph.get(), &cu.arena, llvm_compilation_unit));
  } else {
   switch (compiler.GetInstructionSet()) {
     case kThumb2:
       cu.cg.reset(ArmCodeGenerator(&cu, cu.mir_graph.get(), &cu.arena));
       break;
     case kMips:
       cu.cg.reset(MipsCodeGenerator(&cu, cu.mir_graph.get(), &cu.arena));
       break;
     case kX86:
       cu.cg.reset(X86CodeGenerator(&cu, cu.mir_graph.get(), &cu.arena));
       break;
     default:
   }

  // ここからbackendに切り替え
  cu.cg->Materialize();
      CompilerInitializeRegAlloc();  // Needs to happen after SSA naming

      /* Allocate Registers using simple local allocation scheme */
      SimpleRegAlloc();

      if (mir_graph_->IsSpecialCase()) {
        /*
         * Custom codegen for special cases.  If for any reason the
         * special codegen doesn't succeed, first_lir_insn_ will
         * set to NULL;
         */
        SpecialMIR2LIR(mir_graph_->GetSpecialCase());
      }

      /* Convert MIR to LIR, etc. */
      if (first_lir_insn_ == NULL) {
        //このメソッドはquickとportableの両方に定義されている。
        MethodMIR2LIR();
      }

      /* Method is not empty */
      if (first_lir_insn_) {
      // mark the targets of switch statement case labels
      ProcessSwitchTables();

      /* Convert LIR into machine code. */
      AssembleLIR();
  }


  result = cu.cg->GetCompiledMethod();





ARTの最適化
*******************************************************************************
ファイルは、dex

SSA
PropagateConstatns
CodeLayout
BasicBlockCoombine
NullCheckElimination
LocalValueNumbering
BuildRegLocations

(1 << kLoadStoreElimination) |
(1 << kLoadHoisting) |
(1 << kSuppressLoads) |
(1 << kNullCheckElimination) |
(1 << kPromoteRegs) |
(1 << kTrackLiveTemps) |
(1 << kSafeOptimizations) |
(1 << kBBOpt) |
(1 << kMatch) |
(1 << kPromoteCompilerTemps));

enum opt_control_vector {
  kLoadStoreElimination = 0,
  kLoadHoisting,
  kSuppressLoads,
  kNullCheckElimination,
  kPromoteRegs,
  kTrackLiveTemps,
  kSafeOptimizations,
  kBBOpt,
  kMatch,
  kPromoteCompilerTemps,
  kBranchFusing,
};


dalvikのJITコンパイラとの比較
*******************************************************************************

kLoadStoreElimination = 0,
kLoadHoisting,
kSuppressLoads,
kNullCheckElimination,
kPromoteRegs,
kTrackLiveTemps,
kSafeOptimizations,
    RemoveRedundantBranches
kBBOpt, からっぽ。
kMatch, これはMIRの最適化
kPromoteCompilerTemps, MIRの最適化


Dalvik VMのLIR最適化
===============================================================================

LoadStoreElimination
LoadHoisting

RedundantBranchElimination

CopyPropagation
MergeMovs
introduceBranchDelaySlot
LoadStoreElimination

TrackLiveTemps

SuppressLoads

===============================================================================
===============================================================================

template ::
  ###############################################################################
  *******************************************************************************
  ===============================================================================


artのMIR最適化は新規追加っぽいな。。SSAに変換したのち、constant propagation
null check elimination
combine basic blocks
local value numbering
inliningは今は未実装っぽい。

artのフロントエンドおよびMIRは、quickとportableから見て共通だけど、
さらにSeaIRっていう独自のフロントエンドとIRを並行して開発している。
こちらはLLVM専用のIRで、dexからSeaIRを生成してbitcodeを生成、LLVMに流す。
artのbackendにはもう一つあって、portable これはLLVMを使用する奴で、LIR == bitcode。
独自のPASSであるGBCExpanderを通した後、LLVMのO3相当でコンパイルしてアセンブラを生成する。
artのコンパイルは、dexからMIRに変換して最適化してLIRを生成するfrontendと、
LIRを最適化してアセンブラ生成を行うbackendから構成される。quickは自前のbackendでx86/arm/mipsに対応、
たぶんdalvikから持ってきた。
dalvik vmのLIR最適化一覧と、artのquickのLIR最適化一覧が完全に一致レベルだな、これ。
dart vmの場合、最初に公開されたバージョンからdeoptimization frameworkが作成されていて、
最適時のframeの操作、vregの割り当て、
unboxing前後の値の場所をcfgの各pointからtrackingできるようになっているのは凄いと思いました。
artのentry pointは、classのfieldのputと、LLVMのshadow frameの変更をうまく監視しながら、
保守して作成するのかな。。
LLVMをバックエンドに使っても、safe point(artではentry_point)を生成しないといけないんだっけ？
つーか、ARTやらJavaの場合LLVMにデバッグ情報を渡す必要はなかった。デバッグでbreakしたら、
deoptimizeしてインタプリタに戻してデバッグするんだった。。



