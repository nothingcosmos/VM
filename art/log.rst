art git log
###############################################################################

気になったgit logをメモする。

更新 2014/05


runtime
*******************************************************************************

Add thread unsafe allocation methods to spaces
===============================================================================

SS/GSS Collectors
AllocThreadUnsafe


concurrent Sweeping for non-concurrent GC
===============================================================================

semi-space collector


deoptimzied shadow frames
===============================================================================


exception handling for deoptimization
===============================================================================

QuickExceptionHandler::DeoptimizeStack



===============================================================================
===============================================================================
===============================================================================
===============================================================================

compiler
*******************************************************************************

kDoReadBarrier
===============================================================================

aarch64
===============================================================================

aarch64 jni compiler


===============================================================================

inlining
===============================================================================

inlining on trivial accessors

Inlining synthetic accesors

Location
===============================================================================

Dartっぽい

RegLocation

StackLocation



Quick compiler debugging assists
===============================================================================

インタプリタに戻らないのか？



Transform to SSA phase to the optimizing compiler
===============================================================================

Simplify GenConstString

Skip BBs without SSA rep

Constant Propagation phase

String.IndexOf

Simplify HInvokeStatic

optimizing compiler

add Pass

AtomicLongの使用

CFG printing using DOT

Optimize stack overflow handling

Plug new optimizing compiler in compilation pipeline.


Transpolines
===============================================================================


GC
===============================================================================

add GC mode


LLVM
===============================================================================

コミットは少なめかな。

LLVMはC++11で書き直されているのでしばらくmergeは無理。

a Add command line support for enabling the optimizing compiler.

Also run tests with the optimizing compiler enabled when
the file art/USE_OPTIMIZING_COMPILER is present.

merged r187914. 2013 Aug



build
===============================================================================

SUPPORT arm arm64 mips x86 x86_64

ARTのMode

SMALL_MODE

SEA_IR_MODE

PORTABLE_COMPILER

OPTIMIZING_COMPILER
  --compiler-backend=Optimizing


===============================================================================
===============================================================================

template ::
  ###############################################################################
  *******************************************************************************
  ===============================================================================

