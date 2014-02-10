LLVM GC
###############################################################################

GCをサポートするための機能


LLVM
*******************************************************************************

LLVMの場合、Shadow Frameという概念を使って

module ::

  javaObject = type opaque
  %ShadowFrame = type { i32                  ; Number of VRegs
                      , %ShadowFrame*        ; Previous frame
                      , %JavaObject*         ; Method object pointer
                      , i32                  ; Line number for stack backtrace
                      ; [0 x i32]            ; VRegs
                      }
このShadowFrameは、art/rutime/stack.hで定義されているShadowFrameと対応付けられていて、


GCの概要
===============================================================================

parallel card marking

concurrent card marking

allocate
===============================================================================

Arena

Arenaは、backendのコンパイル時にcu.arenaを引数で渡している。

LIKELYの追加で性能向上

 // Type of allocation for memory tuning.
  +  enum ArenaAllocKind {
  +    kAllocMisc,
  +    kAllocBB,
  +    kAllocLIR,
  +    kAllocMIR,
  +    kAllocDFInfo,
  +    kAllocGrowableArray,
  +    kAllocGrowableBitMap,
  +    kAllocDalvikToSSAMap,
  +    kAllocDebugInfo,
  +    kAllocSuccessor,
  +    kAllocRegAlloc,
  +    kAllocData,
  +    kAllocPredecessors,
  +    kNumAllocKinds
  +  };


art/compiler/llvm
===============================================================================

 // Code mappings for deduplication. Deduplication is already done on a pointer basis by the
 // compiler driver, so we can simply compare the pointers to find out if things are duplicated.
 SafeMap<const std::vector<uint8_t>*, uint32_t> code_offsets_;
 SafeMap<const std::vector<uint8_t>*, uint32_t> vmap_table_offsets_;
 SafeMap<const std::vector<uint8_t>*, uint32_t> mapping_table_offsets_;
 SafeMap<const std::vector<uint8_t>*, uint32_t> gc_map_offsets_;


interpreterへのtrampoline
utilのtrampolineで定義

===============================================================================


GC Root visit
*******************************************************************************

runtimeから、GCのrootをたどる処理

llvm側でも定義されている、
GetCurrentShadwoFrame()
ShadowFrameをひたすらたどる

mirror::ArtMethod* m = shadow_frame->GetMethod()
gc_map = m->GetNativeGcMap();

VRegReference




ShadowFrame
===============================================================================
art/runtime/stackで定義されている。



===============================================================================

template ::
  ###############################################################################
  *******************************************************************************
  ===============================================================================

