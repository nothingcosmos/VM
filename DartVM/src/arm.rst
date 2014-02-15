ARM Assembler
===============================================================================
ARMアセンブラの一般的なことと、Dart VMの実装を織り交ぜながら

参考 http://www.mztn.org/slasm/arm02.html

レジスタ
===============================================================================
基本的にすべて汎用レジスタ。

レジスタ ::

  R0
  R1
  R2
  R3
  R4
  R5
  R6
  R7
  R8
  R9  CTX Caches current context in generated code.(dart vm固有)
  R10 PP  Caches object pool pointer in generated code.(dart vm固有)
  R11 FP  Frame pointer register.
  R12 IP TMPとして使用する。(dart vm固有)
  R13 SP スタックレジスタ
  R14 LR リンクレジスタ(サブルーチンの戻りアドレス)
  R15 PC プログラムカウンタ

ARMのcalling convでは、R0からR3までの4wordの引数を保持する。

返値は、R0とR1で最大2wordを保持する。

64bit保持する場合は、R0R1なのか、R1R0なのか。

FP系のレジスタは複数存在する。 ::

  D0がtempのはず。

  single-precision(floating point registers)
  S0-S31

  double-precision
  D0-D15
  D16-D31   <-- VFPv3のみ。

  レジスタの対応関係は以下。
  [S0S1][S2S3]
  [D0  ][D1  ]

todo ::

  NEONからquadruple-precisionもあるはず。
  だけど、TegraがNEON標準でないため、使いがたいのかも。。

Addressing Mode
===============================================================================

before/after decrement/increment

writeback to baseってなんだっけ。 たぶん!を末尾につける奴。

Syntax op{addr_mode}{cond} Rn{!}, reglist{^}

dest += * (base + offset * scale), base += offset * scale

BlockAddressMode ::

    // Load/store multiple addressing mode.
    // bit encoding P U W
    DA           = (0|0|0) << 21,  // decrement after
    IA           = (0|4|0) << 21,  // increment after
    DB           = (8|0|0) << 21,  // decrement before
    IB           = (8|4|0) << 21,  // increment before
    DA_W         = (0|0|1) << 21,  // decrement after with writeback to base
    IA_W         = (0|4|1) << 21,  // increment after with writeback to base
    DB_W         = (8|0|1) << 21,  // decrement before with writeback to base
    IB_W         = (8|4|1) << 21   // increment before with writeback to base


条件フィールド
===============================================================================

ステータスレジスタ ::

  N Negative
  Z Zero
  C Carry/Borrow
  V Overflow
  Q Overflow

Condition Field[cd] ::

  // Values for the condition field as defined in section A3.2.
  enum Condition {
  kNoCondition = -1,
  EQ =  0,  // equal
  NE =  1,  // not equal
  CS =  2,  // carry set/unsigned higher or same
  CC =  3,  // carry clear/unsigned lower
  MI =  4,  // minus/negative
  PL =  5,  // plus/positive or zero
  VS =  6,  // overflow
  VC =  7,  // no overflow
  HI =  8,  // unsigned higher
  LS =  9,  // unsigned lower or same
  GE = 10,  // signed greater than or equal
  LT = 11,  // signed less than
  GT = 12,  // signed greater than
  LE = 13,  // signed less than or equal
  AL = 14,  // always (unconditional)
  kSpecialCondition = 15,  // special condition (refer to section A3.2.1)
  kMaxCondition = 16,
  };

Enum値がそのままCodeに対応している。

condは、4bitのフィールドのはず。

インストラクション
===============================================================================

Opcode[op] ::

  // Opcodes for Data-processing instructions (instructions with a type 0 and 1)
  // as defined in section A3.4
  enum Opcode {
  kNoOperand = -1,
  AND =  0,  // Logical AND
  EOR =  1,  // Logical Exclusive OR
  SUB =  2,  // Subtract
  RSB =  3,  // Reverse Subtract
  ADD =  4,  // Add
  ADC =  5,  // Add with Carry
  SBC =  6,  // Subtract with Carry
  RSC =  7,  // Reverse Subtract with Carry
  TST =  8,  // Test
  TEQ =  9,  // Test Equivalence
  CMP = 10,  // Compare
  CMN = 11,  // Compare Negated
  ORR = 12,  // Logical (inclusive) OR
  MOV = 13,  // Move
  BIC = 14,  // Bit Clear
  MVN = 15,  // Move Not
  kMaxOperand = 16
  };

Shifter[shift] ::

  // Shifter types for Data-processing operands as defined in section A5.1.2.
  enum Shift {
  kNoShift = -1,
  LSL = 0,  // Logical shift left
  LSR = 1,  // Logical shift right
  ASR = 2,  // Arithmetic shift right
  ROR = 3,  // Rotate right
  kMaxShift = 4
  };

命令の一般的な組み立ては以下になる。 ::

  []はオプショナル。
  Dstはデスティネーションレジスタ
  Srcはソースレジスタ
  Sは、ステータスフラグ更新指定
  immは即値

  op[cd][S] dst, src [,src] [shift] [#imm]


InstructionField
===============================================================================

InstructionField ::

  // Constants used for the decoding or encoding of the individual fields of
  // instructions. Based on the "Figure 3-1 ARM instruction set summary".
  enum InstructionFields {
  kConditionShift = 28,
  kConditionBits = 4,
  kTypeShift = 25,
  kTypeBits = 3,
  kLinkShift = 24,
  kLinkBits = 1,
  kUShift = 23,
  kUBits = 1,
  kOpcodeShift = 21,
  kOpcodeBits = 4,
  kSShift = 20,
  kSBits = 1,
  kRnShift = 16,
  kRnBits = 4,
  kRdShift = 12,
  kRdBits = 4,
  kRsShift = 8,
  kRsBits = 4,
  kRmShift = 0,
  kRmBits = 4,
  
  // Immediate instruction fields encoding.
  kRotateShift = 8,
  kRotateBits = 4,
  kImmed8Shift = 0,
  kImmed8Bits = 8,
  
  // Shift instruction register fields encodings.
  kShiftImmShift = 7,
  kShiftRegisterShift = 8,
  kShiftImmBits = 5,
  kShiftShift = 5,
  kShiftBits = 2,
  
  // Load/store instruction offset field encoding.
  kOffset12Shift = 0,
  kOffset12Bits = 12,
  kOffset12Mask = 0x00000fff,
  
  // Mul instruction register fields encodings.
  kMulRdShift = 16,
  kMulRdBits = 4,
  kMulRnShift = 12,
  kMulRnBits = 4,

  kBranchOffsetMask = 0x00ffffff
  };

dart vm固有の記述
===============================================================================

ShifterOperand()は、shifterを任意に指定するために、間接的なレイヤー


stubs
===============================================================================

内部ClassのAllocatorを生成するStub

基本はcopy gc向けにtopとendのチェック。 内部用なので、既にsizeは分かっていると。

allocator ::

  // Called for inline allocation of objects.
  // Input parameters:
  //   LR : return address.
  //   SP + 4 : type arguments object (only if class is parameterized).
  //   SP + 0 : type arguments of instantiator (only if class is parameterized).
  void StubCode::GenerateAllocationStubForClass(Assembler* assembler,
                                                const Class& cls) {

  //fast caseのみ
  // kInlineInstanceSize is a constant used as a threshold for determining
  // when the object initialization should be done as a loop or as
  // straight line code.
  const int kInlineInstanceSize = 12;
  const intptr_t instance_size = cls.instance_size();
  const intptr_t type_args_size = InstantiatedTypeArguments::InstanceSize();

  //allocate
  Heap* heap = Isolate::Current()->heap();
  __ LoadImmediate(R5, heap->TopAddress());      //Topの取得
  __ ldr(R2, Address(R5, 0));                    //R2にload ここがnew-genの現在の末尾
  __ AddImmediate(R3, R2, instance_size);        //intance_size分加算
  if (is_cls_parameterized) {                    //type argumentをもつ場合、R3へ加算。
    __ ldm(IA, SP, (1 << R0) | (1 << R1));       //arg1 BlockAddressMode, IAはIncrementAfter
                                                 //SPからtype argumentsを、複数レジスタR0とR1にload
    __ mov(R4, ShifterOperand(R3));              //R3からR4へmoveして退避
    // A new InstantiatedTypeArguments object only needs to be allocated if
    // the instantiator is provided (not kNoInstantiator, but may be null).
    __ CompareImmediate(R0, Smi::RawValue(StubCode::kNoInstantiator)); //type argumentsがなければ
    __ AddImmediate(R3, type_args_size, NE);     //NEが条件付き実行 なければ、type_args_sizeを加算
    // R4: potential new object end and, if R4 != R3, potential new
    // InstantiatedTypeArguments object start.
  }
  // Check if the allocation fits into the remaining space.
  // R2: potential new object start.
  // R3: potential next object start.
  if (FLAG_use_slow_path) {
    __ b(&slow_case);
  } else {
    __ LoadImmediate(IP, heap->EndAddress());     //EndAdressをloadして、末尾と比較
    __ cmp(R3, ShifterOperand(IP));               //R3の末尾と比較
    __ b(&slow_case, CS);  // Branch if unsigned higher or equal.  //slow_caseへgo
  }

  // Successfully allocated the object(s), now update top to point to
  // next object start and initialize the object.
  __ str(R3, Address(R5, 0));                     //TopAddressの更新、storeのdestが右にあって違和感。。

  //ここまでcopy gcのallocation
  if (is_cls_parameterized) {
    //面倒なので省略。
  }

  // R2: new object start.
  // R3: next object start.
  // R1: new object type arguments (if is_cls_parameterized).
  // Set the tags.
  uword tags = 0;
  tags = RawObject::SizeTag::update(instance_size, tags);
  tags = RawObject::ClassIdTag::update(cls.id(), tags);
  __ LoadImmediate(R0, tags);                                //タグはasmの見た目は固定値(immediate)
  __ str(R0, Address(R2, Instance::tags_offset()));          //new obj にtagを設定。

  // Initialize the remaining words of the object.
  __ LoadImmediate(R0, reinterpret_cast<intptr_t>(Object::null())); //nullで埋めるために確保

  // R0: raw null.
  // R2: new object start.
  // R3: next object start.
  // R1: new object type arguments (if is_cls_parameterized).
  // First try inlining the initialization without a loop.
  if (instance_size < (kInlineInstanceSize * kWordSize)) {
    // Check if the object contains any non-header fields.
    // Small objects are initialized using a consecutive set of writes.
    for (intptr_t current_offset = sizeof(RawObject);        //headerの分だけoffsetを加算しておく。
         current_offset < instance_size;
         current_offset += kWordSize) {
      __ StoreToOffset(kStoreWord, R0, R2, current_offset);  //nullで埋める。R2+current_offset
    }
  } else {
    __ add(R4, R2, ShifterOperand(sizeof(RawObject)));
    // Loop until the whole object is initialized.
    // R0: raw null.
    // R2: new object.
    // R3: next object start.
    // R4: next word to be initialized.
    // R1: new object type arguments (if is_cls_parameterized).
    Label init_loop;
    Label done;
    __ Bind(&init_loop);
    __ cmp(R4, ShifterOperand(R3));                          //if offset > R3
    __ b(&done, CS);
    __ str(R0, Address(R4, 0));                              //null R4
    __ AddImmediate(R4, kWordSize);                          //R4をインクリメント
    __ b(&init_loop);                                        //loop backedge
    __ Bind(&done);
  }
  if (is_cls_parameterized) {
    // R1: new object type arguments.
    // Set the type arguments in the new object.
    __ StoreToOffset(kStoreWord, R1, R2, cls.type_arguments_field_offset());
  }
  // Done allocating and initializing the instance.
  // R2: new object still missing its heap tag.
  __ add(R0, R2, ShifterOperand(kHeapObjectTag));            //return R0, R2をheaptag付け
  __ Ret();

  __ Bind(&slow_case); //slow_caseでは、
  __ CallRuntime(kAllocateObjectRuntimeEntry);  // Allocate object.


GenerateNArgsheckInlineCacheStub()

GenerateOneArgCheckInlineCacheStub()


下記命令では、IPレジスタをつかって、入力となるレジスタを壊さない。
IPは、Dart VM for ARMにおいてtempとして使いまわすルールである。

StoreIntoObject ::

  StoreIntoObjectFilterNoSmi()
  bicは、value & ~objectによって、valueがnewgen, objectがoldgenであることをチェックしている。
  
  StoreIntoObjectFilter()
  Filterの場合、Smiの可能性もあり、and_でSmiとnewgenの条件を畳み込む。
  その後にbic
  
  StoreIntoObject()
  can_value_be_smiの場合、Filter
  Smiを取りえない場合、NoSmiを呼び出す。
  updateする場合、BranchLink UpdateStoreBufferLabel()
  
  StoreIntoObjectNoBarrier()
  str命令のみ debug時はSToreIntoObjectFilterを呼び出す。

  // Helper stub to implement Assembler::StoreIntoObject.
  // Input parameters:
  //   R0: Address (i.e. object) being stored into.
  void StubCode::GenerateUpdateStoreBufferStub(Assembler* assembler) {
    // Save values being destroyed.
    __ PushList((1 << R1) | (1 << R2) | (1 << R3));             // R1 R2 R3をスピル

    // Load the isolate out of the context.
    // Spilled: R1, R2, R3.
    // R0: Address being stored.
    __ ldr(R1, FieldAddress(CTX, Context::isolate_offset()));   //CTXのcontext cacheからisolate取得。
  
    // Load top_ out of the StoreBufferBlock and add the address to the pointers_.
    // R1: Isolate.
    intptr_t store_buffer_offset = Isolate::store_buffer_block_offset();
    __ LoadFromOffset(kLoadWord, R2, R1,                            //R2へstbfのoffset
                      store_buffer_offset + StoreBufferBlock::top_offset());
    __ add(R3, R1, ShifterOperand(R2, LSL, 2));                     //isolate + stbf
    __ StoreToOffset(kStoreWord, R0, R3,                            //R0のobjaddrをisolateの絶対アドレスを格納。
                     store_buffer_offset + StoreBufferBlock::pointers_offset());
  
    // Increment top_ and check for overflow.
    // R2: top_
    // R1: Isolate
    Label L;
    __ add(R2, R2, ShifterOperand(1));                       //storebufferのincrement
    __ StoreToOffset(kStoreWord, R2, R1,                     //index 確保
                     store_buffer_offset + StoreBufferBlock::top_offset());
    __ CompareImmediate(R2, StoreBufferBlock::kSize);        //R2のオーバーフローチェック
    // Restore values.
    __ PopList((1 << R1) | (1 << R2) | (1 << R3));           //spillされたレジスタを戻す
    __ b(&L, EQ);
    __ Ret();
  
    // Handle overflow: Call the runtime leaf function.      //if overflow
    __ Bind(&L);
    // Setup frame, push callee-saved registers.
  
    __ EnterCallRuntimeFrame(0 * kWordSize);
    __ ldr(R0, FieldAddress(CTX, Context::isolate_offset()));
    __ CallRuntime(kStoreBufferBlockProcessRuntimeEntry);    //overflowしたら、storebufferblockを
    // Restore callee-saved registers, tear down frame.      //storebufferにcopyする。
    __ LeaveCallRuntimeFrame();
    __ Ret();
  }



  void CodeBreakpoint::PatchFunctionReturn() {
    uword* code = reinterpret_cast<uword*>(pc_ - 3 * Instr::kInstrSize);
    ASSERT(code[0] == 0xe8bd4c00);  // ldmia sp!, {pp, fp, lr}
    ASSERT(code[1] == 0xe28dd004);  // add sp, sp, #4
    ASSERT(code[2] == 0xe12fff1e);  // bx lr
    
    // Smash code with call instruction and target address.
    uword stub_addr = StubCode::BreakpointReturnEntryPoint();
    uint16_t target_lo = stub_addr & 0xffff;
    uint16_t target_hi = stub_addr >> 16;
    uword movw = 0xe300c000 | ((target_lo >> 12) << 16) | (target_lo & 0xfff);
    uword movt = 0xe340c000 | ((target_hi >> 12) << 16) | (target_hi & 0xfff);
    uword blx =  0xe12fff3c;
    code[0] = movw;  // movw ip, #target_lo
    code[1] = movt;  // movt ip, #target_hi
    code[2] = blx;    // blx ip
    CPU::FlushICache(pc_ - 3 * Instr::kInstrSize, 3 * Instr::kInstrSize);
  }

  void CodeBreakpoint::RestoreFunctionReturn() {
    uword* code = reinterpret_cast<uword*>(pc_ - 3 * Instr::kInstrSize);
    ASSERT((code[0] & 0xfff0f000) == 0xe300c000);
    code[0] = 0xe8bd4c00;  // ldmia sp!, {pp, fp, lr}
    code[1] = 0xe28dd004;  // add sp, sp, #4
    code[2] = 0xe12fff1e;  // bx lr
    CPU::FlushICache(pc_ - 3 * Instr::kInstrSize, 3 * Instr::kInstrSize);
  }
