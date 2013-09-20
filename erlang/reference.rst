References
###############################################################################

http://ftp.sunet.se/pub/lang/erlang/white_paper.html
===============================================================================

http://ll2.ai.mit.edu/talks/armstrong.pdf
===============================================================================

* Process creation times

jvm csharpは、1000p で終了
100-200ms / process

erlang
2000 - 30,000 process

3-5 microseconds

* Message passing times

jvm csharp

30microsecond

erlang
0.5 - 1 microsecond

* scalable process

重要な点として、
プロセス生成のレイテンシが低い
メッセージ送受信のレイテンシが低い

上記がプロセス数に対してうまくscaleする。プロセス数は30,000くらいまでいける。
JVMやCsharpは1000~2000 processまで

プロセスのscaleに必要なこと

Shared Nothing
lock mutexを無くす

remote process
monitor

* その他の重要項目

failure

耐障害性

ERTS

port/ioの並列化

* erlangの特徴として気づいた点

hot code upgrade/code loading

soft real-time/raytency重視

* coders at work

6th joe armstrong

プログラムはブラックボックスだ。
入力と出力があって、関係的な関係があり、 君の問題はどこにあるのか。


http://www.sics.se/~joe/thesis/armstrong_thesis_2003.pdf
===============================================================================

http://www.trapexit.org/A_Guide_To_The_Erlang_Source
===============================================================================


http://basho.com/erlang-at-basho-five-years-later/
===============================================================================

http://www.slideshare.net/barcampcork/erlang-for-five-nines
===============================================================================

http://www.slideshare.net/nivertech/erlang-otp
===============================================================================

http://www.it.uu.se/research/group/hipe/documents/hipe_manual.pdf
===============================================================================

HiPEの大まかな概要と、インターフェースの一覧、 HiPEの外部仕様

http://www.erlang.se/euc/08/euc_smp.pdf
===============================================================================

OSのプロセスに1VMを立てる。

SMP対応では、複数のschedulerを起動して、run queue を複数のschedulerで処理する。


https://www.erlang-solutions.com/sites/default/files/trimedia/ErlangUserGroup-HiPE-DanielLuna.pdf
===============================================================================

HiPEのコンパイルフローや中間表現に関して

Icode ::

  From Beam
  To Control Flow Graph
  Inline Bifs
  SSA form optimizations
  Dead code elimination
  Constant propagation
  Some type tests
  Lazy code motion
  Back to linear code

RTL ::

  From Icode
  To CFG
  SSA
  As Icode
  Liveness analysis
  More optimizations
  To Linear code

Runtime system ::

  HiPE compiler (Erlang)
  Mode switch Beam/HiPE (asm)
  Glue code for bif calls (m4 macro)
  Garbage collection (C)
  Stubs for BEAM calls (C and asm)
  Loader (C and Erlang)
  Signal stack handling (C)
  Arithmetic overflow (asm and C)
