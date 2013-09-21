疑問点とか、調べたいこと
###############################################################################

* low laytencyの為の仕組み

GCがincrementalで止まらないようになっている。erlang processごとにGCがある。

schedulerを独自で書いており、自由に割り込み、wakeupできるようになっている。

asyncの割り込み、処理は専用のthreadを立てて実行できるようになっている。

message passingはrunqueueに積んで順番に実行かな。

* erlang processの仕組み。

erlang_threads or green thread or ethread が話題らしいけど、、

* processとethreadの関係は

OSのprocessに 1 VMを立てる。 VM内では複数のthreadを立てて、schedulerやasyncを割り振る。

* プロセス間通信の仕組み process間、ノード間は？
基本はmessage passing。process間は特に、普通。erl_message参照

todo node間 dist参照

* 故障時の復帰方法
VM内supervisorがcode indexを使用して、codeを参照してhotloadingするのでは。

code indexは、hot loading, hot paching, upgradeの仕組みを提供する。

VMごと落ちた場合はどうすんだろ


* 異なるアーキテクチャ間のserialization format
external参照。encode/decode

process間はencode/decode行わず、VM内でメモリ確保してlock/unlockして渡すだけ。

* asyncの仕組み
VM内にasync_mainで別スレッドを立てて、いつでもasync処理を受けれるようになっている。

armstrongから一言
===============================================================================

* soft real-time
* fault-tolerant systems
* upgrad without taking them out of service

* 各プロセスに張り付いた高速なGC
* コードを適切に変更する（古いコードと新しいコードが共存できたりするよ）
* 直交したエラー検知のメカニズム (catch-throw/links/ ...)
* プラットフォームに依存したいエラー検知と回復
  (ie to make something fault tolerant needs at least 2 machines,
  think the case when one machine crashes - the second machine must be able to take over)
　
* 分散プリミティブとか、分散ベータベース
* サーバー壊れてもtake over
* 故障モデル、コード変更、コード移動、無停止アップグレード


Q
===============================================================================
* 分散キーバリューストアには、JVMとErlangで組まれたものが多い。 その違いは
Erlangのほうは高信頼性で、JVMはそこそこの性能重視

分散、かつ高信頼性なシステムを作る場合、ErlangのほうがOTP用のライブラリが揃っているのかな

erlang processレベルの障害がどの程度あるのか。
supervisorで監視、復帰処理をしているが、その点はErlangとJVMの違い。

* JVM系の言語は、運用のし易いさや保守性、信頼性、セキュリティをJVMに依存している。
  Erlangの高信頼性を支えることに、VMは寄与しているのか？

ErlangのBEAM VM内にはsupervisorが存在し、erlang process間の障害を監視して回復できる。

ただし、OSのプロセスごとVMが落っこちるような場合、VMは無力なんじゃないかな。

template ::

  ###############################################################################
  *******************************************************************************
  ===============================================================================
