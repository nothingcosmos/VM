何故Unsafe APIは速いのか
####

デシリアライズ速度の比較 ByteBuffer vs DirectBuffer vs Unsafe vs C
http://frsyuki.hatenablog.com/entry/2014/03/12/155231

え、Unsafeってこんなに速いの？と思ったので、いろいろ調べてみました。
...逆にいうとByteBufferを使うとCほどには速くならない。

(1) HotSpot Unsafeの仕組み

unsafe系のAPIは、HotSpotの組み込み関数(vmIntrinsics)に指定されています。
また以降のPrintInliningでも確認できます。

hotspot/src/share/vm/classfile/vmSymbol.hpp
<pre>
do_intrinsic(_getObject,                sun_misc_Unsafe,        getObject_name, getObject_signature,    
do_intrinsic(_getBoolean,               sun_misc_Unsafe,        getBoolean_name, getBoolean_signature,  
do_intrinsic(_getByte,                  sun_misc_Unsafe,        getByte_name, getByte_signature,        
do_intrinsic(_getShort,                 sun_misc_Unsafe,        getShort_name, getShort_signature,      
do_intrinsic(_getChar,                  sun_misc_Unsafe,        getChar_name, getChar_signature,        
do_intrinsic(_getInt,                   sun_misc_Unsafe,        getInt_name, getInt_signature,          
do_intrinsic(_getLong,                  sun_misc_Unsafe,        getLong_name, getLong_signature,        
do_intrinsic(_getFloat,                 sun_misc_Unsafe,        getFloat_name, getFloat_signature,      
do_intrinsic(_getDouble,                sun_misc_Unsafe,        getDouble_name, getDouble_signature,    
do_intrinsic(_putObject,                sun_misc_Unsafe,        putObject_name, putObject_signature,    
do_intrinsic(_putBoolean,               sun_misc_Unsafe,        putBoolean_name, putBoolean_signature,  
do_intrinsic(_putByte,                  sun_misc_Unsafe,        putByte_name, putByte_signature,        
do_intrinsic(_putShort,                 sun_misc_Unsafe,        putShort_name, putShort_signature,      
do_intrinsic(_putChar,                  sun_misc_Unsafe,        putChar_name, putChar_signature,        
do_intrinsic(_putInt,                   sun_misc_Unsafe,        putInt_name, putInt_signature,          
do_intrinsic(_putLong,                  sun_misc_Unsafe,        putLong_name, putLong_signature,        
do_intrinsic(_putFloat,                 sun_misc_Unsafe,        putFloat_name, putFloat_signature,      
do_intrinsic(_putDouble,                sun_misc_Unsafe,        putDouble_name, putDouble_signature, 
</pre>


そもそもvmIntrinsicsが何かというと、
HotSpotでは上記で登録済みのsignatureにパターンマッチして、
Java Bytecodeのinvokeの引数がsignatureにマッチするか判定します。
BytecodeをJITコンパイルする際に、invoke系のBytecodeをCall Nodeに置換しますが、
その呼び出し先を通常のclassのsignatureではなく、vmIntrinsicsとなるように展開します。


vmIntrinsicsへの呼び出しは、各JITコンパイラが個別に命令列に展開していきます。
C2コンパイラであるoptoの対応箇所は以下になります。
hotspot/src/share/vm/opto/library_call.cpp
<pre>
...
case vmIntrinsics::_getInt:                   return inline_unsafe_access(!is_native_ptr, !is_store, T_INT,     !is_volatile);
case vmIntrinsics::_getLong:                  return inline_unsafe_access(!is_native_ptr, !is_store, T_LONG,    !is_volatile);
...
</pre>

optoの中間表現はidealという名前で、Nodeクラスがグラフ構造でつながっています。
library_callではintrinsicsへのCall Nodeを、さらに対応する別のNodeに置換しています。
上記のgetIntやgetLongに関しては、make_laod()により、IdealのLoad Node系に置換します。
LoadNodeは、最終的にCodeGeneratorによりアセンブラに変換されます。。

上記のような仕組みであるため、vmIntrinsicsは
特定のsymbolへの関数呼び出しに置換されるわけではないです。
多くの場合、opto内で対応するNodeにinline展開され、そのままアセンブラに変換されます。



(2) Oracle JVMでログを参照する
Oracle JVMの隠しオプションをいくつか使ってコンパイルログを参照し、
どうなっているのかざっくり把握してみる。

こういうときによく使うオプションは以下です。
"-Xbatch -XX:+UnlockDiagnosticVMOptions -XX:+PrintCompilation -XX:+PrintInlining"

-Xbatchは、JITコンパイルと実行中のプログラムが並行して走らないようにします。
Unlockで-XXオプションを指定可能にします。
PrintCompilationはJITコンパイルしたログを出力します。
PrintInliningはInline展開のログを出力します。

簡単な処理なんかは、上記でどんな傾向なのか分かります。

下記のバージョンでログを確認してみました。
全ログファイルはここを参照。
https://github.com/nothingcosmos/VM/blob/master/OpenJDK/bench/oracle_inlining.log


<pre>
java version "1.7.0_51"
Java(TM) SE Runtime Environment (build 1.7.0_51-b13)
Java HotSpot(TM) 64-Bit Server VM (build 24.51-b03, mixed mode)
</pre>

まずはログの見方を解説
<pre>
5049  104     n 0       sun.misc.Unsafe::compareAndSwapObject (native)   
5170  105     n 0       sun.misc.Unsafe::getByte (native)   
5170  106     n 0       sun.misc.Unsafe::getInt (native)   
5170  107     n 0       sun.misc.Unsafe::getLong (native)   
5188  108 %  b  3       DeserBenchmark$UnsafeRunnable::run @ 10 (98 bytes)
                           @ 29   sun.misc.Unsafe::getByte (0 bytes)   intrinsic
                           @ 55   sun.misc.Unsafe::getInt (0 bytes)   intrinsic
                           @ 82   sun.misc.Unsafe::getLong (0 bytes)   intrinsic
</pre>

JITコンパイルの仕組みや、上記ログのみかたはJRubyを開発しているNutterさんの資料が詳しい。
http://www.slideshare.net/CharlesNutter/presentations


1列目の5049とか5170って数字は、JVM起動からの経過時間(ms)
104-105ってのは、JITコンパイルの順番を表す数値

% OnStackReplacementでJITコンパイルしたメソッドを表す
b なんだっけ、、
n native method、大体はintrinsics
! 例外発生するもの。例外はJITコンパイルに悪影響与える可能性大なので、kernel loopからは取り除くべき

nの隣の数字 0-4に関して
最近のHotSpotのJITコンパイラは4Tier JIT Compilationなので、0-4はその数値です。
0はインタプリタ、1-2はC1コンパイラ、3-4はC2コンパイラだったかな、詳しいことは忘れた。。
数字が出ていない場合は、TierCompilationが無効なはず。

inline (hot) inline展開されたもの
(native) nativeなシンボル。JNIとかもそう。
intrinsic intrinsicへの呼び出しに展開したもの。
too big callerのサイズが大きく、inline展開の閾値の関係で諦めたもの
callee is too large  展開のしすぎでcallee本体が閾値に達したもの



まずはByteBufferRunnable heap
<pre>
    140   12 %  b        DeserBenchmark$ByteBufferRunnable::run @ 13 (74 bytes)
                            @ 23   java.nio.HeapByteBuffer::get (15 bytes)   inline (hot)
                             \-> TypeProfile (11264/11264 counts) = java/nio/HeapByteBuffer
                              @ 7   java.nio.Buffer::checkIndex (22 bytes)   inline (hot)
                              @ 10   java.nio.HeapByteBuffer::ix (7 bytes)   inline (hot)
                            @ 40   java.nio.HeapByteBuffer::getInt (19 bytes)   inline (hot)
                             \-> TypeProfile (5724/5724 counts) = java/nio/HeapByteBuffer
                              @ 5   java.nio.Buffer::checkIndex (24 bytes)   inline (hot)
                              @ 8   java.nio.HeapByteBuffer::ix (7 bytes)   inline (hot)
                              @ 15   java.nio.Bits::getInt (18 bytes)   inline (hot)
                                @ 6   java.nio.Bits::getIntB (30 bytes)   inline (hot)
                                  @ 2   java.nio.HeapByteBuffer::_get (7 bytes)   inline (hot)
                                  @ 9   java.nio.HeapByteBuffer::_get (7 bytes)   inline (hot)
                                  @ 16   java.nio.HeapByteBuffer::_get (7 bytes)   inline (hot)
                                  @ 23   java.nio.HeapByteBuffer::_get (7 bytes)   inline (hot)
                                  @ 26   java.nio.Bits::makeInt (29 bytes)   inline (hot)
                                @ 14   java.nio.Bits::getIntL (30 bytes)   never executed
                            @ 58   java.nio.HeapByteBuffer::getLong (20 bytes)   inline (hot)
                             \-> TypeProfile (5540/5540 counts) = java/nio/HeapByteBuffer
                              @ 6   java.nio.Buffer::checkIndex (24 bytes)   inline (hot)
                              @ 9   java.nio.HeapByteBuffer::ix (7 bytes)   inline (hot)
                              @ 16   java.nio.Bits::getLong (18 bytes)   inline (hot)
                                @ 6   java.nio.Bits::getLongB (60 bytes)   inline (hot)
                                  @ 2   java.nio.HeapByteBuffer::_get (7 bytes)   inline (hot)
                                  @ 9   java.nio.HeapByteBuffer::_get (7 bytes)   inline (hot)
                                  @ 16   java.nio.HeapByteBuffer::_get (7 bytes)   inline (hot)
                                  @ 23   java.nio.HeapByteBuffer::_get (7 bytes)   inline (hot)
                                  @ 30   java.nio.HeapByteBuffer::_get (7 bytes)   inline (hot)
                                  @ 37   java.nio.HeapByteBuffer::_get (7 bytes)   inline (hot)
                                  @ 45   java.nio.HeapByteBuffer::_get (7 bytes)   inline (hot)
                                  @ 53   java.nio.HeapByteBuffer::_get (7 bytes)   inline (hot)
                                  @ 56   java.nio.Bits::makeLong (77 bytes)   inline (hot)
                                @ 14   java.nio.Bits::getLongL (60 bytes)   too big

</pre>

見どころは
(a) TypeProfile
  抽象クラスのメソッドやinterfaceは、どの実装が呼び出されるのかわからないので、
  どの実装が呼び出されているのかprofileしている。
  この段階ではHeapByteBufferのみなので、ガードを挿入した上でHeapByteBufferのコードを展開している。
  optoのinline展開は、静的にクラス階層解析するのではなく、
  ログ取得したTypeProfile任せにinline展開先を決定する。

(b) intrinsicsが存在しない。
  HeapByteBufferはintrinsicsをwrapしたものではない。



ByteBufferRunnable direct
<pre>
   2374   14 %  b        DeserBenchmark$ByteBufferRunnable::run @ 13 (74 bytes)
                            @ 23   java.nio.HeapByteBuffer::get (15 bytes)   inline (hot)
                            @ 23   java.nio.DirectByteBuffer::get (16 bytes)   inline (hot)
                             \-> TypeProfile (4096/16384 counts) = java/nio/DirectByteBuffer
                             \-> TypeProfile (12288/16384 counts) = java/nio/HeapByteBuffer
                              @ 6   java.nio.Buffer::checkIndex (22 bytes)   inline (hot)
                              @ 9   java.nio.DirectByteBuffer::ix (10 bytes)   inline (hot)
                              @ 12   sun.misc.Unsafe::getByte (0 bytes)   (intrinsic)
                              @ 7   java.nio.Buffer::checkIndex (22 bytes)   inline (hot)
                              @ 10   java.nio.HeapByteBuffer::ix (7 bytes)   inline (hot)
                            @ 40   java.nio.HeapByteBuffer::getInt (19 bytes)   inline (hot)
                            @ 40   java.nio.DirectByteBuffer::getInt (15 bytes)   inline (hot)
                             \-> TypeProfile (2034/8273 counts) = java/nio/DirectByteBuffer
                             \-> TypeProfile (6239/8273 counts) = java/nio/HeapByteBuffer
                              @ 5   java.nio.Buffer::checkIndex (24 bytes)   inline (hot)
                              @ 8   java.nio.DirectByteBuffer::ix (10 bytes)   inline (hot)
                              @ 11   java.nio.DirectByteBuffer::getInt (39 bytes)   too big
                              @ 5   java.nio.Buffer::checkIndex (24 bytes)   inline (hot)
                              @ 8   java.nio.HeapByteBuffer::ix (7 bytes)   inline (hot)
                              @ 15   java.nio.Bits::getInt (18 bytes)   inline (hot)
                                @ 6   java.nio.Bits::getIntB (30 bytes)   inline (hot)
                                  @ 2   java.nio.HeapByteBuffer::_get (7 bytes)   inline (hot)
                                  @ 9   java.nio.HeapByteBuffer::_get (7 bytes)   inline (hot)
                                  @ 16   java.nio.HeapByteBuffer::_get (7 bytes)   inline (hot)
                                  @ 23   java.nio.HeapByteBuffer::_get (7 bytes)   inline (hot)
                                  @ 26   java.nio.Bits::makeInt (29 bytes)   inline (hot)
                                @ 14   java.nio.Bits::getIntL (30 bytes)   never executed
                            @ 58   java.nio.HeapByteBuffer::getLong (20 bytes)   inline (hot)
                            @ 58   java.nio.DirectByteBuffer::getLong (16 bytes)   inline (hot)
                             \-> TypeProfile (2062/8111 counts) = java/nio/DirectByteBuffer
                             \-> TypeProfile (6049/8111 counts) = java/nio/HeapByteBuffer
                              @ 6   java.nio.Buffer::checkIndex (24 bytes)   inline (hot)
                              @ 9   java.nio.DirectByteBuffer::ix (10 bytes)   inline (hot)
                              @ 12   java.nio.DirectByteBuffer::getLong (39 bytes)   too big
                              @ 6   java.nio.Buffer::checkIndex (24 bytes)   inline (hot)
                              @ 9   java.nio.HeapByteBuffer::ix (7 bytes)   inline (hot)
                              @ 16   java.nio.Bits::getLong (18 bytes)   inline (hot)
                                @ 6   java.nio.Bits::getLongB (60 bytes)   inline (hot)
                                  @ 2   java.nio.HeapByteBuffer::_get (7 bytes)   inline (hot)
                                  @ 9   java.nio.HeapByteBuffer::_get (7 bytes)   inline (hot)
                                  @ 16   java.nio.HeapByteBuffer::_get (7 bytes)   inline (hot)
                                  @ 23   java.nio.HeapByteBuffer::_get (7 bytes)   inline (hot)
                                  @ 30   java.nio.HeapByteBuffer::_get (7 bytes)   inline (hot)
                                  @ 37   java.nio.HeapByteBuffer::_get (7 bytes)   inline (hot)
                                  @ 45   java.nio.HeapByteBuffer::_get (7 bytes)   inline (hot)
                                  @ 53   java.nio.HeapByteBuffer::_get (7 bytes)   inline (hot)
                                  @ 56   java.nio.Bits::makeLong (77 bytes)   inline (hot)
                                @ 14   java.nio.Bits::getLongL (60 bytes)   too big

</pre>

見どころは
(c) TypeProfileが複数存在する。
  ここでDirectByteBufferとHeapByteBufferの2つの呼び出しログが衝突している。
  複数のガードを挿入した上で、双方をインライン展開している。
  はっきりいうとHeapByteBufferが邪魔

(d) DirectByteBufferのgetByteがintrinsic
  Unsafe::getByteをwrapしているらしい。
  ここが性能の差かもしれない。。

(e) too big
  DirectByteBufferのgetIntとgetLongが重要なのに、
  HeapByteBufferのTypeProfileが邪魔でinline展開できていない。。

  @ 11   java.nio.DirectByteBuffer::getInt (39 bytes)   too big
  @ 12   java.nio.DirectByteBuffer::getLong (39 bytes)   too big

これは、、と思ったのでコードを変更して測定しなおしてみる。
何を変えたかというと、最初のHeapByteBufferを呼び出さずに、
DirectBufferとUnsafeの呼び出しのみ行う。

実行結果
<pre>

変更前
-- ByteBuffer heap
  11.23 msec/loop
  849.22 MB/s
-- ByteBuffer direct
  9.18 msec/loop
  1038.86 MB/s
-- Unsafe heap
  6.26 msec/loop
  1523.44 MB/s
-- Unsafe direct
  6.30 msec/loop
  1513.77 MB/s

変更後
-- ByteBuffer direct
  6.89 msec/loop
  1384.14 MB/s
-- Unsafe heap
  6.24 msec/loop
  1528.32 MB/s
-- Unsafe direct
  6.23 msec/loop
  1530.78 MB/s
</pre>

Unsafeの性能は変わらないけど、ByteBuffer directの実行性能が大きく上がっている。
ログでも内容を確認してみる。

<pre>
    264   12 %  b        DeserBenchmark$ByteBufferRunnable::run @ 13 (74 bytes)
                            @ 23   java.nio.DirectByteBuffer::get (16 bytes)   inline (hot)
                             \-> TypeProfile (11264/11264 counts) = java/nio/DirectByteBuffer
                              @ 6   java.nio.Buffer::checkIndex (22 bytes)   inline (hot)
                              @ 9   java.nio.DirectByteBuffer::ix (10 bytes)   inline (hot)
                              @ 12   sun.misc.Unsafe::getByte (0 bytes)   (intrinsic)
                            @ 40   java.nio.DirectByteBuffer::getInt (15 bytes)   inline (hot)
                             \-> TypeProfile (5724/5724 counts) = java/nio/DirectByteBuffer
                              @ 5   java.nio.Buffer::checkIndex (24 bytes)   inline (hot)
                              @ 8   java.nio.DirectByteBuffer::ix (10 bytes)   inline (hot)
                              @ 11   java.nio.DirectByteBuffer::getInt (39 bytes)   inline (hot)
                                @ 10   sun.misc.Unsafe::getInt (0 bytes)   (intrinsic)
                                @ 26   java.nio.Bits::swap (5 bytes)   inline (hot)
                                  @ 1   java.lang.Integer::reverseBytes (26 bytes)   (intrinsic)
                            @ 58   java.nio.DirectByteBuffer::getLong (16 bytes)   inline (hot)
                             \-> TypeProfile (5540/5540 counts) = java/nio/DirectByteBuffer
                              @ 6   java.nio.Buffer::checkIndex (24 bytes)   inline (hot)
                              @ 9   java.nio.DirectByteBuffer::ix (10 bytes)   inline (hot)
                              @ 12   java.nio.DirectByteBuffer::getLong (39 bytes)   inline (hot)
                                @ 10   sun.misc.Unsafe::getLong (0 bytes)   (intrinsic)
                                @ 26   java.nio.Bits::swap (5 bytes)   inline (hot)
                                  @ 1   java.lang.Long::reverseBytes (46 bytes)   (intrinsic)

</pre>

見どころは
(f) TypeProfileはDirectByteBufferのみになった。
  Profile結果1つだけなので、inline展開し易くなっている。
  inline展開の閾値を操作するだけでも性能は上がったかもしれない。

(g) DirectByteBufferのメソッドは、最終的にUnsafeのintrinsicに展開されている。
  too bigが解消されて、UnsafeのgetInt getLongまで展開されている。
  DirectByteBufferはUnsafeをwrapしたクラスっぽい。


Unsafe heap
<pre>
   4262   29 %  b        DeserBenchmark$UnsafeRunnable::run @ 10 (98 bytes)
                            @ 29   sun.misc.Unsafe::getByte (0 bytes)   (intrinsic)
                            @ 55   sun.misc.Unsafe::getInt (0 bytes)   (intrinsic)
                            @ 82   sun.misc.Unsafe::getLong (0 bytes)   (intrinsic)
</pre>

最後にUnsafeですが、、、
な…　何を言っているのか　わからねーと思うが　
おれも　何をされたのか　わからなかった…

Unsafeのメソッドがintrinsicなので、上記のようなTypeProfileを気にしなくてもよいので、こんな結果に。
これは確かにCと同等のコードが生成されますよね。。


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
