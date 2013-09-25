疑問点とか、調べたいこと
###############################################################################

* low laytencyの仕組み

GCがerlang process単位でincremental GC。全体を止めないようになっている。

erlang processのscheduler兼インタプリタを自前で書いており、
自由に割り込み、wakeup、context switchできるようになっている。

asyncの処理と割り込みは、async専用のthreadを立てて実行できるようになっている。デフォ10thread。

message passingはerlang process単位にqueueを用意し、順番にdequeueして実行。

* erlang processの仕組み。

OSのprocessに 1 VMを立てる。 VM内では複数のthreadを立てて、schedulerやasyncを割り振る。

OSのThreadは、起動時に20～23程度起動する。

erlang processは、OSのthreadやprocessとは別もので、独自生成、独自管理。

processのリソース管理は、malloc/free

* プロセス間通信の仕組み process間、ノード間は？

基本はmessage passing。process間はlock 相手のqueueに送って、unlock。 erl_message参照

ノード間もmessage passingだが、ノード間の場合はencode/decodeした上で、
相手ノードのportにmessageを送信する。

ノードは、host名とportから構成されており、NodeListみたいのでVMが管理している。

* 故障時の復帰方法

VM内に別Threadで立っているsupervisorがcode indexを使用し、別erlang processへ復帰処理を行う。

code indexは、hot loading, hot paching, upgradeの仕組みを提供している。

VMごと落ちた場合はどうしようもないため、他のNodeからlinkをはったり、生死監視する必要がある。

* 異なるアーキテクチャ間のserialization format

external参照。encode/decode

* asyncの仕組み

VM内にasync_mainで別スレッドを立てて、いつでもasync処理を受けれるようになっている。

### todo

link機能に関して

lock/unlockの仕組み。


Q
===============================================================================
* 分散キーバリューストアには、JVMとErlangで組まれたものが多い。 その違いは

Erlangのほうは高信頼性で、JVMはそこそこの性能重視なのかも。

分散、かつ高信頼なシステムを作る場合、ErlangのほうがOTP用のライブラリが揃っており、作り易い。

* JVM系の言語は、運用のし易いさや保守性、信頼性、セキュリティをJVMに依存している。
  Erlangの高信頼性を支えることに、VMは寄与しているのか？

ErlangのBEAM VM内にはsupervisorが存在し、erlang process間の障害を監視して回復できる。

linkもVMの機能のような気がする。

erlang processレベルの障害がどの程度あるのかは不明。
supervisorで監視、復帰処理をしているが、その点はErlangとJVMの違い。

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


template ::

  ###############################################################################
  *******************************************************************************
  ===============================================================================
