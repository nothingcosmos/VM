V8 SpeedUp
###############################################################################

V8で大きく性能向上したコミットを記録
https://www.dartlang.org/performance/

DeltaBlue
===============================================================================

19300周辺

Version 3.24.35 (based on bleeding_edge revision r19214)
Fix inconsistencies wrt whitespaces (issue 3109).
Performance and stability improvements on all platforms.

Richards
===============================================================================

Aggressive Inlining

Tracer
===============================================================================

StoreSinkingの追加


FluidMotion
===============================================================================

18411

19622でup
r19589 | hpayer@chromium.org | 2014-02-28 01:59:32 +0900 (金, 28  2月 2014) | 15 lines
Merged r19535, r19549, r19586, r19584 into trunk branch.
Fix for a smi stores optimization on x64 with a regression test.
Fix for failing asserts in HBoundsCheck code generation on x64: index register should be zero extended.
Fix putting of prototype transitions. The length is also subject to GC, just like entry.
Handle arguments objects in frame when materializing arguments


19789でdown
Revert "Enable Object.observe by default"

