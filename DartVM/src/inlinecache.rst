

TwoArgsCheckInlineCache


void StubCode::GenerateTwoArgsCheckInlineCacheStub(Assembler* assembler) {
  GenerateUsageCounterIncrement(assembler, EBX);
  GenerateNArgsCheckInlineCacheStub(assembler, 2);
}

counterincrement
  usage_ount < 2000
  goto is_hot
  else incl usage_count_offset


GenerateNArgsCheckInlineCacheStub(assembler, 2);
// - If receiver is null -> jump to IC miss.
// - If receiver is Smi -> load Smi class.
// - If receiver is not-Smi -> load receiver's class.
  class_id_as_is_smi



label
  CallRuntime(inlineCacheMissHandlerXXXArgRuntimeEntry)

  //NosuchMethod or closure
  StubCode::InstanceFunctionLoopupLabel()

  found:
    addl count_offset
  call_tasrget_function:
    jmp(EAX)
  get_class_id_as_smi:
    ret()
  not_smi:
    LoadClassId
    ret()



最終的に、UpdateICDataTwoArgs

か、ResolveCompileInstanceCallTarget()



わからないな。。

Token::kADD

RawInteger* Integer::ArighmeticOp() ???


addFromInteger ???


intrinsifier_ia32.cc
これ？？ Integer_add

これか？



dart:core__IntegerImplementation@0x36924d72_+function 
たぶんこれか。
なぞだ。。
