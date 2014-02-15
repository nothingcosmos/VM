
r26773
Collect edge count profiling data and reorder basic blocks.

DeltaBlue and Richards is speed up


21696  compare optimization
21692 stackoverflow elimination

21235 collect type feedback

20373 storebarrier optimize

21682 branch optimization

18399 redundant load elimination

13840 inlining


DeltaBlue
===============================================================================

r23020 | srdjan@google.com | 2013-05-23 00:20:55 +0900 (木, 23  5月 2013) | 5 lines
Improve constant propagation for Mint and Smi.
R=kmillikin@google.com
Review URL: https://codereview.chromium.org//15507006

r23018 | srdjan@google.com | 2013-05-22 23:32:18 +0900 (水, 22  5月 2013) | 5 lines
Allow stack location for some instructions (relational and equality comparison).
R=fschneider@google.com
Review URL: https://codereview.chromium.org//15578003
上記いずれかでDeltaBlueが向上

Richards
===============================================================================

Tracer
===============================================================================
===============================================================================
===============================================================================
