疑問点とか、やりたいことまとめ
###############################################################################

gcの仕組み low laytency

erlang_process の仕組み。何て呼ぼう

erlang_threads or green thread or ethread

processとethreadの関係は

プロセス間通信の仕組み process, ethread
message passingの基本的な仕組み process単位

故障時のprocessの復帰方法

異なるアーキテクチャ間のserialization format

ethreadとの連携方法は？mail boxではないのか？

mail_boxなんて用語ないよう。

async_mainからの割り込みの仕組み。

arm strongから一言
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


Question
===============================================================================
分散キーバリューストアには、JVMとErlangで組まれたものが多い。 その違いは

JVM系の言語は、運用のし易いさや保守性、信頼性、セキュリティをJVMに依存している。

Erlangの高信頼性を支えることに、VMは寄与しているのか？

template ::

  ###############################################################################
  *******************************************************************************
  ===============================================================================
