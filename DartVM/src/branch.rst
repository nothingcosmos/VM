branch
###############################################################################
current - 29800
randomの追加

AndImmediate
TestImmediate

ControlInstruction rename -> BranchInstr

TestSmiInstr
a and b == 0のケースで置換する




*******************************************************************************

===============================================================================
===============================================================================


*******************************************************************************

===============================================================================
===============================================================================




r30119 | srdjan@google.com | 2013-11-09 02:42:45 +0900 (土, 09 11月 2013) | 5 lines
Constant fold strict comparison based on incoming types:
different (exact) types means that the result is false.
LoadStaticField computes type for final fields. Make a temporary buffer final.
R=kmillikin@google.com
Review URL: https://codereview.chromium.org//57703004
特定条件化でdynamicでない場合、kEQ_STRICT に変換


r30058 | fschneider@google.com | 2013-11-08 02:27:16 +0900 (金, 08 11月 2013) | 10 lines
VM: Fix identical comparisons with bigints.

The optimizing compiler did not properly preserve registers across
the runtime call that occurs when using identical with bigints.

BUG=http://dartbug.com/14903
TEST=tests/language/vm/regress_14903_test.dart
R=srdjan@google.com
Review URL: https://codereview.chromium.org//64723002






neider@google.com | 2013-11-07 20:47:04 +0900 (木, 07 11月 2013) | 31 lines
Cleanup of branch code generation (no change in functionality).
This CL is the first step in refactoring the way branches and comparisons are generated.

1. Move helper functions from flow_graph_compiler_xyz.cc to
  intermediate_language_xyz.cc.

2. Remove IL class ControlInstruction. It was only implemented by BranchInstr.
  All functions provided are moved to BranchInstr.

3. When generating branch code for comparisons, pass the successor labels explicitly
  instead of getting them from the branch. This will allow us to provide different labels
  when materialize a bool value of a comparison.

4. Move some common code for IfThenElseInstr from the platform-specific files
  into intermediate_language.cc and simplify it.

The goal is to enable if-conversion of arbitrary comparisons. Right now,
the code for == is hard-coded in IfThenElseInstr (and duplicated, too). This
means that e.g. "a < b ? 0 : 1" cannot be optimized.



s a result, IfThenElseInstr can be used to materialize the boolean  value of
a comparison. This way the complication of having ComparisonInstr both as a
normal instruction and as wrapped inside a BranchInstr can be simplified.
Comparisons would no longer appear as plain instructions in the IL, but only
wrapped inside either a Branch or an IfThenElse(true, false).

R=zra@google.com
Review URL: https://codereview.chromium.org//62133002
これもcompareの最適化




r29985 | fschneider@google.com | 2013-11-07 03:28:37 +0900 (木, 07 11月 2013) | 11 lines
VM: Fix double comparisons using != and NaN in optimized code.

With a double x

x == double.NAN should false and x != double.NAN should be true.

TEST=tests/language/double_nan_comparison_test.dart
BUG=https://code.google.com/p/dart/issues/detail?id=14867
R=srdjan@google.com
Review URL: https://codereview.chromium.org//62443002



neider@google.com | 2013-11-06 21:13:29 +0900 (水, 06 11月 2013) | 14 lines
Merge (x & y) == 0 pattern to emit a single test instruction.

This is based on a previous uncommitted CL by vegorov@
(https://codereview.chromium.org/14251023/).

It is rebased and fixes a bug in the MIPS implementation: BranchOnCondition
requires the comparison result in fixed registers CMPRES1/CMPRES2.

Remove register alias TMP1 (=TMP) and CMPRES (=CMPRES1). It is confusing to
have them around and easy to forget that they are actually the same.

R=srdjan@google.com, zra@google.com
Review URL: https://codereview.chromium.org//59613005

TestSmiInstrを追加
RecognizedTestPattern (a & b) == 0

普通にtestlアセンブラを出力する。




r29800 | fschneider@google.com | 2013-11-04 20:32:52 +0900 (月, 04 11月 2013) | 15 lines
Change == into an instance call to allow polymorphic inlining of ==.

In unoptimized code equality is now just another instance call.

The optimizer replaces it with a specialized implementation based on static
type information and type feedback.

Many of the manual optimizations of == in the optimizer are now just handled
by the generic inliner, plus polymorphic inlining of == calls is now possible.
This also eliminates the need for a lot of duplicated code in the backend.

I adapted the inlining heuristics to compensate for the slightly larger inital flow graph size.
Review URL: https://codereview.chromium.org//27307005



