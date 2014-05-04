Optimize
###############################################################################

commit 818f2107e6d2d9e80faac8ae8c92faffa83cbd11
Author: Nicolas Geoffray <ngeoffray@google.com>
Date:   Tue Feb 18 16:43:35 2014 +0000

Re-apply: Initial check-in of an optimizing compiler.

The classes and the names are very much inspired by V8/Dart.
It currently only supports the RETURN_VOID dex instruction,
and there is a pretty printer to check if the building of the
graph is correct.

Change-Id: I28e125dfee86ae6ec9b3fec6aa1859523b92a893

compiler/optimizing
===============================================================================

builder.h

HGraph これはV8由来の名前っぽい。

HBasicBlock

HInstruction

Exit
Goto
ReturnVoid


Graphは、
code_ptrを参照して、
AnalyzeDexInstruction

DexをHGraphに変換するのか。

GenerateFrameEntry
GenerateFrameExit

optimizeはどこから呼ばれる。
===============================================================================

2014/03頭の段階では、どこからも呼び出しはないっぽいな。

ARTはcompiler/optimizing
ってディレクトリを追加して、ファイルを整理。
またHGraphってを追加している。これはV8由来CrankshaftのHIRと名前が一致。
まだ呼び出しはどこにもない。

code generatorが追加されて、V8 Crankshaftっぽくなってきた。


OptimizingCompiler::TryCompile
HGraphBuilder::BuildGraphが起点

===============================================================================
===============================================================================

OptimizingCompiler
*******************************************************************************

compiler.ccでコンパイラを切り替えている。

Compiler::Create()

QuickCompiler

OptimizingCompiler

LLVMCompiler //Portable

OptimizingCompiler::TryCompile
===============================================================================

flow ::

  DexCompilationUnit()

  HGraphBuolder builder.BuildGraph()
    HBasicBlockを生成
    ComputeBranchTargets()

  driver.GetInstructionSet()
  CodeGenerator::Create()

  CodeVectorAllocator allocator;
  codegen->Compile(&allocator);
    GenerateFrameEntry()
    CompileBlock()
    Allocate()
    MemoryRegion code

  codegen->BuildMappingTAble
  codegen->BuildVMapTable
  codegen->BuildNativeGCMap

  //ここにあるのはおかしい。メインパスに入ってないだけか？
  graph->BuildDominatorTree()
  graph->TransformToSSA()

  return new CompiledMethod()


最適化？
===============================================================================

test ::

  HGraphBuilder builder BuildGraph()
  BuildDominatorTree()
  TransformToSSA()
    SimplifyCFG()
    ssa_builder.BuildSsa()

  なんもやってない。

===============================================================================
===============================================================================
===============================================================================

template ::
  ###############################################################################
  *******************************************************************************
  ===============================================================================

