android4.4/art
###############################################################################

ディレクトリ構成
*******************************************************************************

::
  art
    compiler
      dex           //dexの簡易コンパイラ。portableとquickを切り替える
      driver        //DexCompilationUnit LlvmCompilationUnit
      jni           //
      llvm          //LlvmCompilationUnit
      sea_ir        //SeaIrCompilationUnit
      trampolines   //jumpをarch非依存の命令にwrap
      utils
    runtime
      arch
      base          //logging histgram mutex string fileio
      entrypoints   //safepoint相当。compilerが生成したコードが呼び出すintrinsic
        interpreter //dex interpreter
        jni
        portable    //LLVMのintrinsicの関数定義
        quick
      gc
        accounting
        allocator
        collector
        space
      hprof
      interpreter
      jdwp
      mirror        //compiler側に公開するproxyオブジェクト群。Javaのreflection
      native
      verifier

dex
*******************************************************************************

ちゃんとみてない。

===============================================================================

sea_ir
*******************************************************************************

起点は

static CompiledMethod* CompileMethodWithSeaIr
CompiledMethod* SeaIrCompileMethod

ifdef ART_SEA_IR_MODE が必要。

こちらもLLVMを叩くらしい。

LlvmComplationUnitと何が違うのかというと、
こちらはintrinsincを定義せず、GBCExpanderも使用しない。

まだ使用できない。

詳細
===============================================================================

type/TypeInference

sea_ir region
SSA形式のSeaGraph
RPOってなんだろ reverse post-order of regions

main ::
  // Two passes: Builds the intermediate structure (non-SSA) of the sea-ir for the function.
  BuildMethodSeaGraph(code_item, dex_file, class_def_idx, method_idx, method_access_flags);
  // Pass: Compute reverse post-order of regions.
  ComputeRPO();
  // Multiple passes: compute immediate dominators.
  ComputeIDominators();
  // Pass: compute downward-exposed definitions.
  ComputeDownExposedDefs();
  // Multiple Passes (iterative fixed-point algorithm): Compute reaching definitions
  ComputeReachingDefs();
  // Pass (O(nlogN)): Compute the dominance frontier for region nodes.
  ComputeDominanceFrontier();
  // Two Passes: Phi node insertion.
  ConvertToSSA();
  // Pass: type inference
  ti_->ComputeTypes(this);
  // Pass: Generate LLVM IR.
  CodeGenData* cgd = GenerateLLVM(function_name, dex_file);

data flow analysisしたいのか。

GenerateLLVM

CodeGenPrepass
Generate LLVM IRを作成

こちらではgbc_expanderは使用しない。

type-inferenceの後に何かやりたいんだと思う。

art::DexFile


LLVM
*******************************************************************************

LLVMを内包する

LLVMのコントロールは、以下で行う。

(1) intrinsicの定義
(2) MetaDataの定義
(3) GBCExpander
(4) intrinsicの解決にDexFileを与える

LLVMと連携するIntrinsicsを定義して、
GBCExpanderでbitcodeレベルに展開する、もしくはruntimeで用意しているsymbolへ置換する。

runtime_support_llvm_func_list.h
こちらがruntimeに実際に定義されている関数群
art::llvm::runtime_support

intrinsicはart_module.llでも組み込み関数として定義されている。

intrinsic_func_list.def
===============================================================================

Thread

Exception

ConstString

ConstClass

Lock

Cast

Allocation

Instance

Array

InstanceFieldGet/Put

Static Field Get/Put

Invoke

Math

Greenland_ir (MIR to Greenland_ir)

Monitor enter/exit

Shadow Frame

Comparison (FP lang)

Shift intrinsics. (dalvikとllvmは違うのでwrap)

Memory barrier


GC系は何があるのか。

MarkGCCard


Metadata
===============================================================================

Metadataの用途は,TBAAとBranchWeightのみ。今のところは。

LLVMには、LLVMの通常のtypeと,jtype,さらには、register,stack,heapが混在するため、
MetadataでTBAAの定義を追加する。

Art TBAA Root

BranchWeight

SpecialType
JType

TBAAはさらに細分化されて、
Register
StackTemp
HeapArray
HeapInstance
HeapStatic
JRuntime
RuntimeInfo
ShadowFrame
ConstJObject

Intrinsic系の引数は最大で5個
expand_arg5


SHadowFrameがキモか。

%ShadowFrame = type { i32                  ; Number of VRegs
                    , %ShadowFrame*        ; Previous frame
                    , %JavaObject*         ; Method object pointer
                    , i32                  ; Line number for stack backtrace
                    ; [0 x i32]            ; VRegs
                    }


GBCExpanderPass
===============================================================================
LLVM FunctionPassを1つ実装している。

上記のruntimeで定義されていない
intrinsicsをexpandしてllvm-irに変換する。
put/get系はほとんど解決

DexOffテーブルを参照するのか。

InsertStackOverflowCheck
RewriteFunction
verify

LV2UInt(DexOff


llvm_compilation_unit.cc
===============================================================================

LLVM PassManagerの生成 コンパイルオプションはO3相当を与える

IPOは今のところ無効化。inline展開も無効化。

inline展開するためには、inline展開した関数を覚えておいて、
classloadingに応じてdeoptimizeできるようにする仕組みが必要。

IPOもinternalizeと
手続き間別名解析は、JavaのClassLoading


MaterializeToRawOStream()
===============================================================================

codeGenの作成オプション。
llvm::CodeGenOpt::Aggressive
llvm::CodeModel::Small

PassManager
最初にGBCを追加する。その後


PassManager ::

  // Add optimization pass
  ::llvm::PassManagerBuilder pm_builder;
  // TODO: Use inliner after we can do IPO.
  pm_builder.Inliner = NULL;
  // pm_builder.Inliner = ::llvm::createFunctionInliningPass();
  // pm_builder.Inliner = ::llvm::createAlwaysInlinerPass();
  // pm_builder.Inliner = ::llvm::createPartialInliningPass();
  pm_builder.OptLevel = 3;
  pm_builder.DisableUnitAtATime = 1;
  pm_builder.populateFunctionPassManager(fpm);
  pm_builder.populateModulePassManager(pm);
  pm.add(::llvm::createStripDeadPrototypesPass());


===============================================================================
===============================================================================

compiler
*******************************************************************************
Compile

quick
portable

ArtCompileMethod art::DexFile::CodeItem

CompilerDriver(CompilerBackend backend,,,
これでquickとportableを切り替える。


===============================================================================
===============================================================================
