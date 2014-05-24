GC(Garbage Collection)
###############################################################################

場所はpkg/runtime/mgc

GCの概要
===============================================================================

mark&sweep
mostly precise (with the exception of some C-allocated objects, assembly frames/arguments, etc)
parallel (up to MaxGcproc threads)
partially concurrent (mark is stop-the-world, while sweep is concurrent)
non-moving/non-compacting
full (non-partial)

GOGC=100



mgc0
*******************************************************************************

mgc0.c
mgc0.go
mgc0.h


malloc
===============================================================================

GCの概要
===============================================================================

GCの起点
===============================================================================



===============================================================================
===============================================================================
===============================================================================
===============================================================================
===============================================================================


*******************************************************************************

===============================================================================
===============================================================================

heap確保の起点はこれか。

func new(typ * byte) * any

もしくは
pkg/builtin ::

  // The new built-in function allocates memory. The first argument is a type,
  // not a value, and the value returned is a pointer to a newly
  // allocated zero value of that type.
  func new(Type) * Type

pkg/runtime
*******************************************************************************

malloc.goc ::

  // Allocate an object of at least size bytes.
  // Small objects are allocated from the per-thread cache's free lists.
  // Large objects (> 32 kB) are allocated straight from the heap.
  // If the block will be freed with runtime·free(), typ must be 0.
  void*
  runtime.mallocgc(size, typ, flag)

  void
  runtime.free(void *v)

MaxSmallSizeより小さい場合と、大きい場合がある。 ::

  if (size <= MAxSmallSize) {
    runtime.size_to_class8[]
    runtime.size_to_class128[]

    flag & FlagNoZero
      zerofillを制御できる。
    c->local_cachealloc += size;
  } else {
    runtime.MHeap_Alloc()
    // setup for mark sweep
    runtime.markspan()
  }

  FlagNoGCって制御がある


===============================================================================

===============================================================================



make channel
*******************************************************************************

lex.c

"make" OMAKE

"<-" LCOMM

go.y
===============================================================================

expr LCOMM expr 
OSEND $1 $3

LCOMM uexpr
ORECV $2 N

OTCHAN
Csend
Crecv

go.h
===============================================================================

Crecv ORECV OSELRECV OSELRECV2
Csend OSEND
Cboth Crecv | Csend




===============================================================================

template ::
  ###############################################################################
  *******************************************************************************
  ===============================================================================

