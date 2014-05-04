Pyston
###############################################################################

blog要約
*******************************************************************************
https://tech.dropbox.com/2014/04/introducing-pyston-an-upcoming-jit-based-python-implementation/

Dropbox

C++で開発

既にpythonのJITを使用した実装はいろいろある。

PyPy tracing JIT
Jython and IronPythonは、その下のVMがJITコンパイルをサポートしている。

method-at-a-time JITとして実装したい。

conservative gabarge collector

using LLVM

type speculation

inline caches

README
===============================================================================

python 2.7 and x86_64


4tiers
1.LLVM-IR itnerpreter
2.Baseline LLVM compilation type recording
3.Improved LLVM compilation
4.Full LLVM optimization, uses type feedback

今はlow tierへ戻れない

いろんなテクニック
===============================================================================
Inlining

Object Representation, boxed model
int flaot bool

Inline caches

Hidden classes

Type feedback

Garbage collection

Aspiration: Extension modules

Aspiration: Thread-level Parallelism



===============================================================================
===============================================================================
===============================================================================
*******************************************************************************
*******************************************************************************

===============================================================================
===============================================================================

template ::
  ###############################################################################
  *******************************************************************************
  ===============================================================================

