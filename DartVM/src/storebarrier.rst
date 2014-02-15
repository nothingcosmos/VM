DLRT_StoreBufferBlockProcess
StoreBuffer

     :        void StoreBufferBlock::ProcessBuffer(Isolate* isolate) {                               
     :          StoreBuffer* buffer = isolate->store_buffer();                                       
     :          int32_t end = top_;                                                                  
0.00 :         81d20a8:       mov    %edx,0x18(%esp)                                            
     :          for (int32_t i = 0; i < end; i++) {                                                  
0.00 :         81d20ac:       jle    81d2137 <DLRT_StoreBufferBlockProcess+0xb7>                
0.00 :         81d20b2:       movl   $0x0,0x10(%esp)                                                 ▒
0.00 :         81d20ba:       lea    0x0(%esi),%esi                                                  ▒
     :            buffer->AddPointer(pointers_[i]);                                                  ▒
0.13 :         81d20c0:       mov    0x10(%esp),%edx                                                 ▒
48.83:         81d20c4:       mov    0x1c(%esp),%eax                                                 ▒
0.00 :         81d20c8:       mov    0x4(%eax,%edx,4),%esi                                           ▒
     :              Isolate::Current()->ScheduleInterrupts(Isolate::kStoreBufferInterrupt);          ▒
     :            }                                                                                  ▒
     :          }                                                                                    ▒
     :        }

StoreBufferBlock::AddPointer(uward)
  ProcessBuffer()
    ProcessBuffer(Isolate*)
      buffer->AddPointer(uward)
        Isolate::Current()->ScheduleInterrupts(Isolate::kStoreBufferInterrupt)

StoreBufferBlock::AddPointer(uward)
  <-- gc_marker.cc::MarkObject(RawObject*, RawObject**)
  <-- scavenger.cc:UpdateStoreBuffer()


bool Value::NeedsStoreBuffer() const {
  const intptr_t cid = ResultCid();
  if ((cid == kSmiCid) || (cid == kBoolCid) || (cid == kNullCid)) {
    return false;
  }
  return !BindsToConstant();
}

intermediate_language.h:  bool NeedsStoreBuffer() const;
intermediate_language.h:    return value()->NeedsStoreBuffer() && emit_store_barrier_;

