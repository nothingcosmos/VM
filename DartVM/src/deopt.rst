Deoptimization
###############################################################################

GenerateDeoptimizationStub
===============================================================================

deoptimizationには、eagerとlazyが存在する。

lazyの場合、EAXレジスタを保護する。

runtime/vm/stub_code_ia32.cc ::

  // TOS: return address + call-instruction-size (5 bytes).
  // EAX: result, must be preserved
  void StubCode::GenerateDeoptimizeLazyStub(Assembler* assembler) {
    // Correct return address to point just after the call that is being
    // deoptimized.
    __ popl(EBX);
    __ subl(EBX, Immediate(CallPattern::InstructionLength()));
    __ pushl(EBX);
    GenerateDeoptimizationSequence(assembler, true);  // Preserve EAX.
  }

  void StubCode::GenerateDeoptimizeStub(Assembler* assembler) {
    GenerateDeoptimizationSequence(assembler, false);  // Don't preserve EAX.
  }

eaxがpreservedされているのかどうかを、最初に判定している。

lazyなほうが、保存するEAXが少なくてすむ。退避レジスタ数からInstructionLength()分引いている。


stub deoptimize
===============================================================================

Stubは、optimized frameからunoptimized frameへ変換する。
optimized frameは、registerとstackに値を含んでいる。
unoptimized frameは、全ての値をstackに含んでいる。

deoptimizeは、以下のステップで行う。
1. レジスタの値を全てpushする。
2. 全てのstackとレジスタをtemporary bufferにコピーする
3. 呼び出し側のcallerrのフレームを、unoptimized frameのサイズに調整する。
4. unoptimized frameで埋める
5. Materialize Object(xmmの値を、Double型もしくはMint型にUnboxingして格納しなおす)

image ::

  //   +------------------+
  //   | PC marker        | <- TOS
  //   +------------------+
  //   | Saved FP         | <- FP of stub
  //   +------------------+
  //   | return-address   |  (deoptimization point)
  //   +------------------+
  //   | ...              | <- SP of optimized frame
  //
  // Parts of the code cannot GC, part of the code can GC.


static void GenerateDeoptimizationSequence(Assembler* assembler, bool preserve_eax) ::

    __ EnterFrame(0);
    // The code in this frame may not cause GC. kDeoptimizeCopyFrameRuntimeEntry
    // and kDeoptimizeFillFrameRuntimeEntry are leaf runtime calls.
    const intptr_t saved_eax_offset_from_ebp = -(kNumberOfCpuRegisters - EAX);
    // Result in EAX is preserved as part of pushing all registers below.

    // Push registers in their enumeration order: lowest register number at
    // lowest address.
    for (intptr_t i = kNumberOfCpuRegisters - 1; i >= 0; i--) {   //1. レジスタをstackに退避
      __ pushl(static_cast<Register>(i));
    }
    __ subl(ESP, Immediate(kNumberOfXmmRegisters * kDoubleSize)); //1. xmmレジスタの退避領域計算
    intptr_t offset = 0;
    for (intptr_t reg_idx = 0; reg_idx < kNumberOfXmmRegisters; ++reg_idx) {
      XmmRegister xmm_reg = static_cast<XmmRegister>(reg_idx);    //1. xmmレジスタをstackに退避
      __ movsd(Address(ESP, offset), xmm_reg);
      offset += kDoubleSize;
    }

    __ movl(ECX, ESP);  // Saved saved registers block.
    __ ReserveAlignedFrameSpace(1 * kWordSize);
    __ SmiUntag(EAX);
    __ movl(Address(ESP, 0), ECX);  // Start of register block.
    __ CallRuntime(kDeoptimizeCopyFrameRuntimeEntry);             //2. FrameのCopy
    // Result (EAX) is stack-size (FP - SP) in bytes, incl. the return address.
  
    if (preserve_eax) {
      // Restore result into EBX temporarily.
      __ movl(EBX, Address(EBP, saved_eax_offset_from_ebp * kWordSize));
    }
  
    __ LeaveFrame();
    __ popl(EDX);  // Preserve return address.                  //3. resize frame
    __ movl(ESP, EBP);
    __ subl(ESP, EAX);                                          //return address - unopt stack size
    __ movl(Address(ESP, 0), EDX);

    __ EnterFrame(0);
    __ movl(ECX, ESP);  // Get last FP address.
    if (preserve_eax) {
      __ pushl(EBX);  // Preserve result.
    }
    __ ReserveAlignedFrameSpace(1 * kWordSize);
    __ movl(Address(ESP, 0), ECX);
    __ CallRuntime(kDeoptimizeFillFrameRuntimeEntry);   //4. fill frame and deopt execute
    // Result (EAX) is our FP.                          //   and deopt buff finalize
    if (preserve_eax) {
      // Restore result into EBX.
      __ movl(EBX, Address(EBP, -1 * kWordSize));
    }
    // Code above cannot cause GC.
    __ LeaveFrame();
    __ movl(EBP, EAX);
  
    // Frame is fully rewritten at this point and it is safe to perform a GC.
    // Materialize any objects that were deferred by FillFrame because they
    // require allocation.
    AssemblerMacros::EnterStubFrame(assembler);
    if (preserve_eax) {
      __ pushl(EBX);  // Preserve result, it will be GC-d here.
    }
    __ CallRuntime(kDeoptimizeMaterializeDoublesRuntimeEntry); //5. materialize xmm reg to double or mint
    if (preserve_eax) {                                        //deopt executeで確定したregをmaterialize
      __ popl(EAX);  // Restore result.
    }
    __ LeaveFrame();
    __ ret();
  }


if (preserved_eax)って沢山はいってますね。

最後のMaterializeが完了するまでは、安全にGCできない。

xmmに格納された値をframeに退避するだけでは不十分で、Double型もしくはMint型にしてMaterialize(Stackに配置)する必要がある。

Materializeは、レジスタ割付の用語かな？



Deoptimization Details
===============================================================================

begin deoptimize ->translate base line


kDeoptimizeCopyFrameRuntimeEntry
===============================================================================
code_generator.cpp ::

  // Copies saved registers and caller's frame into temporary buffers.
  // Returns the stack size of unoptimized frame.

  fpの計算
  CopySavedRegisters()
    単純にsaved_registers_addressから順に、cpu_registers_copy[]に値を退避。
    それらはisolateに格納。isolate.set_deopt_cpu_registers_copy()
  unoptimized_stack_sizeの計算

kDeoptimizeFillRuntimeEntry
===============================================================================
code_generator.cpp ::

  // The stack has been adjusted to fit all values for unoptimized frame.
  // Fill the unoptimized frame.
  cpu_regs
  fpu_regs
  frame_copy

  DeoptimizeWithDeoptInfo()
  isolateのdeopt領域の初期化

kDeoptimizeMaterializeRuntimeEntry
===============================================================================
code_generator.cpp ::

  // This is the last step in the deoptimization, GC can occur.
  // Returns number of bytes to remove from the expression stack of the
  // bottom-most deoptimized frame. Those arguments were artificially injected
  // under return address to keep them discoverable by GC that can occur during
  // materialization phase.

  MaterializeDeferredBoxes() <-- doubles, mints, simd まずはprimitive型から
  MaterializeDeferredObjects() <-- その後instance


DeoptimizeWithDeoptInfo()
===============================================================================
code_generator.cpp ::


  deopt_context

  DeoptimizationContext
    code.objet_table()
    GetFieldCount()
    GetToFrameAddressAt()
    deopt_instructions->Execute()

DeoptimizationContext
===============================================================================
deopt_instructions.cpp ::

DeoptInstr

Location

CompilerDeoptInfo::CreateDeoptInfo

CompilerDeoptInfo
===============================================================================
Environment* deopt_env_

AllocateIncomingParametersRecursive(deopt_env)
EmitMaterializations(deopt_env)

envがLocationを管理している。


Environment
===============================================================================
  values_
  locations_
  deopt_id_
  function_
  outer_


===============================================================================
===============================================================================


LazyStubの場合は、preserve EAX.
===============================================================================

まとめ
===============================================================================
