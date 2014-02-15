

stubs
======

GenerateCallStaticFunctionStub

  CallRuntime(kPatchStaticCallRuntimeEntry

code_generator.cc
====

PC Descriptors for function 'file:///home/elise/language/dart/work/adven/fibo.dart_::_main' {
pc              kind            deopt-id        tok-ix  try-ix
0xb304818c      fn-call         5               42      -1
0xb304818c      deopt-after     5               42      -1
0xb30481ac      other           -1              0       -1
0xb30481b1      return          -1              47      -1
0xb30481c1      other           -1              38      -1
0xb30481c3      patch           -1              0       -1
0xb30481c8      lazy-deopt      -1              0       -1
}
Static call target functions {
  0xb304818c: file:///home/elise/language/dart/work/adven/fibo.dart_::_fibo, 0xb5440019
  ^
  caller_frame->pc()
}

PatchStaticCall

const Function& target_function = Function::Handle(
      caller_code.GetStaticCallTargetFunctionAt(caller_frame->pc()));
if (!target_function.HasCode()) {
  Compiler::CompileFunction(target_function)
}



