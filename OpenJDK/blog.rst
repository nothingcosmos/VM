

(3) OpenJDKでJITコンパイルしたコードを逆アセンブルする

疲れたので後日更新予定。。




-XX:+PrintCompilation

zombie

not entrant

uncommon trap

! exception
n native
% osr
s

右端はtier

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



1f9   B21: #    B6 <- B38 B20  Freq: 52395.9
1f9     movq    R8, [rsp + #24] # spill
1fe     movq    [R8], RAX       # long ! Field: DeserBenchmark$ByteBufferRunnable.v64
201     movl    RBX, [rsp + #0] # spill
204     addl    RBX, #9 # int
207     movq    RCX, [rsp + #32]        # spill
20c     jmp     B6

0ae   B6: #     B7 <- B21 B5  Freq: 104894
0ae     incl    RBX     # int
0b0     testl  rax, [rip + #offset_to_poll_page]        # Safepoint: poll for GC        # DeserBenchmark$B
# OopMap{r8=Derived_oop_[8] rcx=Derived_oop_[8] [8]=Oop [16]=Derived_oop_[8] off=176}
0b6     movq    R13, [rsp + #8] # spill
0bb     movl    RBP, [rsp + #4] # spill
0bf     movq    RDX, [rsp + #16]        # spill
0bf
0c4   B7: #     B32 B8 <- B3 B39 B6     Loop: B7-B6 inner  Freq: 104895
0c4     cmpl    RBX, RBP
0c6     jge     B32  P=0.000000 C=40960.000000
0c6
0cc   B8: #     B27 B9 <- B7  Freq: 104895
0cc     testq   R13, R13        # ptr
0cf     je     B27  P=0.000001 C=-1.000000
0cf
0d5   B9: #     B41 B10 <- B8  Freq: 104895
0d5     movl    R10, [RDX]      # compressed ptr ! Field: DeserBenchmark$ByteBufferRunnable.src
0d8     movl    R11, [R10 + #8 (8-bit)] # compressed klass ptr
0dc     NullCheck R10
0dc
0dc   B10: #    B30 B11 <- B9  Freq: 104895
0dc     cmpl    R11, narrowklass: precise klass java/nio/HeapByteBuffer: 0x00007f5a2c0b52a8:Constant:exact
0e3     jne,u  B30  P=0.000001 C=-1.000000
0e3
0e9   B11: #    B28 B12 <- B10  Freq: 104895
0e9     decode_heap_oop_not_null RSI,R10
0ec     # checkcastPP of RSI
0ec     movl    R10, [RSI + #44 (8-bit)]        # compressed ptr ! Field: java/nio/ByteBuffer.hb
0f0     testl   RBX, RBX
0f2     jl     B28  P=0.000001 C=-1.000000
0f2
0f8   B12: #    B28 B13 <- B11  Freq: 104895
0f8     movl    R9, [RSI + #28 (8-bit)] # int ! Field: java/nio/Buffer.limit
0fc     cmpl    RBX, R9
0ff     jge     B28  P=0.000001 C=-1.000000





30d   B32: #    N528 <- B7  Freq: 0.0500179
30d     addq    rsp, 64 # Destroy frame
        popq   rbp
        testl  rax, [rip + #offset_to_poll_page]        # Safepoint: poll for GC
318     ret



288     ret
288
289   B31: #    N444 <- B22 B21  Freq: 0.0574409

unsafe heap
====

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
120
125   B7: #     N105 <- B4 B1  Freq: 1
125     addq    rsp, 16 # Destroy frame
        popq   rbp
        testl  rax, [rip + #offset_to_poll_page]        # Safepoint: poll for GC

130     ret


====
