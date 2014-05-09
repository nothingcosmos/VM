(3) OpenJDKでJITコンパイルしたコードを逆アセンブルする

Oracle JVMでは不可能ですが、OpenJDKをDebug版でビルドすれば、
JITコンパイルしたアセンブラを出力することができます。

JVMのことが信用ならんかたは試してみてください。

-XX:+PrintOptoAssembly

C2コンパイラでコンパイルしたアセンブラを出力するオプションです。

ここからはOpenJDK8をfastdebugモードにビルドして使用しました。


zombie

not entrant

uncommon trap

unsafeはjvm内から生のポインタを直接操作するから、危険 segv注意

ByteBuffer自体は、primitiveといってもやっぱりオブジェクトにwrapされた存在なので、

deoptimize
====

java.util.Random::nextBytes

DeserBenchmark$ByteBufferRunnable::run deopt置きすぎて遅い。

bytebuffer heap
====

src ::

    public void run() {
      int last = src.limit() - 9;
      for(int i=0; i < last; i++) {
        byte b = src.get(i);
        i++;
        if(b < 0) {
          v32 = src.getInt(i);
          i += 4;
        } else {
          v64 = src.getLong(i);
          i += 8;
        }
      }
    }

  R8 = this
  if R8 != DirectByteBuffer goto deopt;
  int last = src.limit() - 9;
  do {
    //B8 checkIndex 0<
    //B9 checkIndex <limit
    //B10
    R13 = base
    R8 = address + i
    RSI = movslq [R13 + R8] //byte load

    R11 = base
    PCX = address + i + 1
    RAX = R11 + PCX

    if (RSI < 0) {
      //B16 checkIndex 0<
      //B17 checkIndex <4
      //B18 nativeByteOrder flagチェックして必要ならばbswapl
      R9 = movl [R11];
      v32 = R9
      i += 5
    } else {
      //B11 checkIndex 0<
      //B12 checkIndex <8
      //B13 nativeByteOrder flagチェックして必要ならばbswapl
      v64 = movq [R11];
      i += 9
    }
    //B7
    i++;
  } while(i<last);



#r018 rsi:rsi   : parm 0: DeserBenchmark$ByteBufferRunnable:NotNull *
# -- Old rsp -- Framesize: 64 --
#r191 rsp+60: in_preserve
#r190 rsp+56: return address
#r189 rsp+52: in_preserve
#r188 rsp+48: saved fp register
#r187 rsp+44: pad2, stack alignment
#r186 rsp+40: pad2, stack alignment
#r185 rsp+36: Fixed slot 1
#r184 rsp+32: Fixed slot 0
#r199 rsp+28: spill
#r198 rsp+24: spill
#r197 rsp+20: spill
#r196 rsp+16: spill
#r195 rsp+12: spill
#r194 rsp+ 8: spill
#r193 rsp+ 4: spill
#r192 rsp+ 0: spill


020   B1: #     B25 B2 <- BLOCK HEAD IS JUNK   Freq: 1
020     # stack bang
        pushq   rbp     # Save rbp
        subq    rsp, #48        # Create frame

02c     movq    RCX, RSI        # spill
02f     movl    R10, [RSI + #24 (8-bit)]        # compressed ptr ! Field: DeserBenchmark$ByteBufferRunnable.src
033     movl    R8, [R10 + #8 (8-bit)]  # compressed klass ptr
037     NullCheck R10
037
037   B2: #     B21 B3 <- B1  Freq: 0.999999
037     movl    RDX, #-9        # int
03c     addl    RDX, [R10 + #28 (8-bit)]        # int
040     testl   RDX, RDX
042     jle     B21  P=0.000000 C=49151.000000
042
048   B3: #     B24 B4 <- B2  Freq: 0.999999
048     cmpl    R8, narrowklass: precise klass java/nio/DirectByteBuffer: 0x00007f5fc00ba7a8:Constant:exact *
04f     jne,u  B24  P=0.000001 C=-1.000000
04f
055   B4: #     B8 <- B3  Freq: 0.999997
055     decode_heap_oop_not_null RBP,R10
058     # checkcastPP of RBP
058     movzbl  R10, [RBP + #42 (8-bit)]        # ubyte ! Field: java/nio/ByteBuffer.nativeByteOrder
05d     movq    R8, [RBP + #16 (8-bit)] # long ! Field: java/nio/Buffer.address
061     movl    R11, [RBP + #28 (8-bit)]        # int ! Field: java/nio/Buffer.limit
065     movq    R13, R8 # long->ptr
068     xorl    RBX, RBX        # int
06a     jmp,s   B8
        nop     # 4 bytes pad for loops and calls

070   B5: #     B6 <- B18  top-of-loop Freq: 144509
070     bswapl  R9
070
073   B6: #     B7 <- B5 B19  top-of-loop Freq: 144509
073     movl    [RCX + #12 (8-bit)], R9 # int ! Field: DeserBenchmark$ByteBufferRunnable.v32
077     addl    RBX, #5 # int
07a
07a   B7: #     B21 B8 <- B15 B6  Freq: 288436
07a     incl    RBX     # int

07c     testl  rax, [rip + #offset_to_poll_page]        # Safepoint: poll for GC        # DeserBenchmark$ByteBuf
        # OopMap{rcx=Oop rbp=Oop off=124}
082     cmpl    RBX, RDX
084     jge     B21  P=0.000000 C=49150.000000
084
08a   B8: #     B20 B9 <- B4 B7         Loop: B8-B7 inner  Freq: 288437
08a     testl   RBX, RBX
08c     jl,s   B20  P=0.000001 C=-1.000000
08c
08e   B9: #     B20 B10 <- B8  Freq: 288437
08e     cmpl    RBX, R11
091     jge,s   B20  P=0.000001 C=-1.000000
091
093   B10: #    B16 B11 <- B9  Freq: 288437
093     movl    R9, R11 # spill
096     subl    R9, RBX # int
099     movslq  R8, RBX # i2l
09c     movsbl  RSI, [R13 + R8] # byte
0a2     decl    R9      # int
0a5     movl    R8, RBX # spill
0a8     incl    R8      # int
0ab     movslq  RDI, R8 # i2l
0ae     movq    RAX, R13        # spill
0b1     addq    RAX, RDI        # ptr
0b4     testl   RSI, RSI
0b6     jl,s   B16  P=0.501007 C=49151.000000
0b6
0b8   B11: #    B23 B12 <- B10  Freq: 143928
0b8     testl   R8, R8
0bb     jl     B23  P=0.000000 C=10752.000000
0bb
0c1   B12: #    B23 B13 <- B11  Freq: 143928
0c1     cmpl    R9, #8
0c5     jl,s   B23  P=0.000000 C=10752.000000
0c5
0c7   B13: #    B15 B14 <- B12  Freq: 143928
0c7     movq    R8, [RAX]       # long
0ca     testl   R10, R10
0cd     jne,s   B15  P=0.000000 C=5375.000000

0cd
0cf   B14: #    B15 <- B13  Freq: 143928
0cf     bswapq  R8
0cf
0d2   B15: #    B7 <- B14 B13  Freq: 143928
0d2     movq    [RCX + #16 (8-bit)], R8 # long ! Field: DeserBenchmark$ByteBufferRunnable.v64
0d6     addl    RBX, #9 # int
0d9     jmp,s   B7
0d9
0db   B16: #    B22 B17 <- B10  Freq: 144509
0db     testl   R8, R8
0de     jl,s   B22  P=0.000000 C=10752.000000
0de
0e0   B17: #    B22 B18 <- B16  Freq: 144509
0e0     cmpl    R9, #4
0e4     jl,s   B22  P=0.000000 C=10752.000000
0e4
0e6   B18: #    B5 B19 <- B17  Freq: 144509
0e6     movl    R9, [RAX]       # int
0e9     testl   R10, R10
0ec     je     B5  P=1.000000 C=5375.000000
0ec
0f2   B19: #    B6 <- B18  Freq: 0.0689071
0f2     jmp     B6





unsafe heap
====

public void run() ::
  int last = length - 9;
  for(int i=0; i < last; i++) {
    byte b = unsafe.getByte(base, address + i);
    i++;
    if(b < 0) {
      v32 = unsafe.getInt(base, address + i);
      i += 4;
    } else {
      v64 = unsafe.getLong(base, address + i);
      i += 8;
    }
  }

  int last = length - 9;
  do {
      R9 = base
      R11 = address + i
      R9 = movslq [R9 + R11] //byte load

      R11 = base
      PCX = address + i + 1
      R11 = R11 + PCX

    if (R9 < 0) {
      R9 = movl [R11];
      v32 = R9
      i += 5
    } else {
      R11 = movq [R11];
      v64 = R11
      i += 9
    }
    i++;
  } while(i<last);



#r018 rsi:rsi   : parm 0: DeserBenchmark$UnsafeRunnable:NotNull *
# -- Old rsp -- Framesize: 32 --
#r191 rsp+28: in_preserve
#r190 rsp+24: return address
#r189 rsp+20: in_preserve
#r188 rsp+16: saved fp register
#r187 rsp+12: pad2, stack alignment
#r186 rsp+ 8: pad2, stack alignment
#r185 rsp+ 4: Fixed slot 1
#r184 rsp+ 0: Fixed slot 0

020   B1: #     B7 B2 <- BLOCK HEAD IS JUNK   Freq: 1
020     subq    rsp, #24        # Create frame
        movq    [rsp + #16], rbp        # Save rbp

02c     movl    R10, #-9        # int
032     addl    R10, [RSI + #32 (8-bit)]        # int
036     testl   R10, R10
039     jle     B7  P=0.000000 C=49151.000000
039

03f   B2: #     B5 <- B1  Freq: 1
03f     xorl    R8, R8  # int
042     jmp,s   B5
042
044   B3: #     B4 <- B5  top-of-loop Freq: 500925
044     
044     movl    R9, [R11]       # int
047     
047     movl    [RSI + #12 (8-bit)], R9 # int ! Field: DeserBenchmark$UnsafeRunnable.v32
04b     addl    R8, #5  # int
04f

04f   B4: #     B7 B5 <- B6 B3  top-of-loop Freq: 1e+06
04f     incl    R8      # int
052     testl  rax, [rip + #offset_to_poll_page]        # Safepoint: poll for GC        # DeserBenchmark$U
# OopMap{rsi=Oop off=82}
058     cmpl    R8, R10
05b     jge     B7  P=0.000000 C=49150.000000
05b
061   B5: #     B3 B6 <- B2 B4  Loop: B5-B4 inner  Freq: 1e+06
061     movl    R9, [RSI + #36 (8-bit)] # compressed ptr ! Field: DeserBenchmark$UnsafeRunnable.base
065     movslq  R11, R8 # i2l
068     addq    R11, [RSI + #24 (8-bit)]        # long
06c     
06c     movsbl  R9, [R9 + R11]  # byte
071     
071     movl    R11, [RSI + #36 (8-bit)]        # compressed ptr ! Field: DeserBenchmark$UnsafeRunnable.ba
075     movl    RBX, R8 # spill
078     incl    RBX     # int
07a     decode_heap_oop R11,R11
102     movslq  RCX, RBX        # i2l
105     addq    RCX, [RSI + #24 (8-bit)]        # long
109     addq    R11, RCX        # ptr
10c     testl   R9, R9
10f     jl     B3  P=0.500926 C=49151.000000
10f

115   B6: #     B4 <- B5  Freq: 499074
115     
115     movq    R11, [R11]      # long
118     
118     movq    [RSI + #16 (8-bit)], R11        # long ! Field: DeserBenchmark$UnsafeRunnable.v64
11c     addl    R8, #9  # int
120     jmp     B4

125   B7: #     N105 <- B4 B1  Freq: 1
125     addq    rsp, 16 # Destroy frame
        popq   rbp
        testl  rax, [rip + #offset_to_poll_page]        # Safepoint: poll for GC

130     ret


====
