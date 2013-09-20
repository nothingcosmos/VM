VM Architecture
###############################################################################

JVMとDart VMとBEAM VMを比較したいが為に、BEAM VMのソースコードを読んできました。。

JVMはOracle HotSpot

Dart VMとBEAM VMは自明。

比較
*******************************************************************************

対応OS ::

  JVM     : Windows, Linux, FreeBSD(MacOS), Solaris
            AIXは非公式サポート
  Dart VM : Windows, Linux, MacOS, Android
            ブラウザは、IE9, IE10, Safari, Chrome, Firefox, dartium
  BEAM VM : Windows, Pthread系のUNIX

対応マシンアーキテクチャ ::

  JVM     : x86, x64, Sparc, Zero
            Powerは非公式サポート、ARM対応は非公開
  Dart VM : ia32, x64, ARM, MIPS
  BEAM VM : HiPEが使えなくなるだけで、コンパイルできればなんでも動く ???
            HiPE(x86, amd64, arm, sparc, ppc系)

対応プラットフォーム ::

  JVM     : 名目上マルチプラットフォームへの対応を目指していたが、
            今は専らサーバ専用。クライアント何それ。
            組込み機器でも使用可能。JavaMEとして、SDKとVM本体を別途リリースしている。
  Dart VM : サーバ用とクライアントのブラウザへの対応を目指している。
            ブラウザはDartiumのみ対応。他はjsに変換して動かす。
            サーバ用のIOライブラリと、クライアント用のhtmlライブラリに分かれる。
            Androidでも動くが、メモリ消費量がJVMと変わらないため、リッチな環境でないと厳しい。
  BEAM VM : 高可用性を目指したサーバ専門

プログラムの実行方法 ::

  JVM     : Bytecode Interpreter, Client JIT Compiler, Server JIT Compiler
  Dart VM : Generic JIT Compiler, Optimized JIT Compiler
  BEAM VM : Bytecode Interpreter, HiPE(native compiler)

Bytecode ::

  JVM     : Java bytecode
  Dart VM : なし
  BEAM VM : Beam Instruction Set

中間表現 ::

  JVM     : c1JIT (HIR, LIR)
            c2JIT (Ideal, ADL, Machine Ideal)
  Dart VM : FlowGraphCompiler (ななしのInstruction)
  BEAM VM : なし？ bytecode intepreter
            HiPE (Icode, RTL)

OSプロセスとの関係 ::

  JVM     : 1 OS Process, 1 VMの生成
  Dart VM : 1 OS Process, 1 VMの生成
  BEAM VM : 1 OS Process, 1 VMの生成

スレッドのようなもの ::

  JVM     : JVMのThreadがあり、OSのthreadをwrapしている。
  Dart VM : Threadなし。代わりにIsolateがある。
  BEAM VM : Threadなし。代わりにerlang processがある

  Dart VM : 1 Thread に 1 Isolate を割り当てる。
            SpawnFunction等でThreadを生成、対応するIsolateを生成。
            Isolateの新規生成時に、ObjectStoreの生成, CoreLibのデシリアライズと読み込み、
            Heapの生成、GCの生成、JITコンパイラの生成、spawnした関数を読み込む。

  BEAM VM : SMP対応済み。
            起動時に下記関数をThreadで生成する。
            signal_dispatcher_thread_func
            sys_msg_dispatcher_func
            async_main * 10         //await待ちのthreadかな?
            child_waiter
            sched_thread_func * 8   //これがscheduler兼interpreter
            aux_thread
            runq_supervisor

            erl_processを Eterm erl_create_process() にて作成する。
            spawnの際に上記が呼ばれ、関数を引数に指定する。


メモリマネージメント ::

  JVM     : GC (世代別。G1GC, NewGCとOldGCをそれぞれ切り替えれる)
            高スループット版のparallel GCと、
            低停止版のCuncurrent GC, G1GC
            IBMのテスタロッサは違うらしい
  Dart VM : Isolate単位にGC (世代別。NewGCがCopy GC, OldGCがMask&Sweep)
  BEAM VM : Erlang Process単位にGC。Incremental GCらしい。SweepしてCompaction


標準ライブラリ ::

  JVM     : たくさん。SDK, 組み込み用SDKに分かれる。
  Dart VM : たくさん。IO, htmlの2種類
  BEAM VM : たくさん。

開発されている言語 ::

  JVM     : C++, Assembler, ADL
  Dart VM : C++, Assembler
  BEAM VM : C  , Assembler


C/C++の外部プログラムとの連携方法 ::

  JVM     : JNI
  Dart VM : Native Extension (やってることはほぼJNI)
  BEAM VM : bif(builtin function) erlangの組み込み関数もbifで定義

並列プログラミングのサポート ::

  JVM     : concurrent collectionや、fork join, JDK8からstreamで並列化
  Dart VM : Isolate間にメモリを共有しない、message passing Isolate間のみサポート。
            サーバ間は別途ライブラリ使って記述。
  BEAM VM : Erlang Process間にメモリを共有しない、message passing
            Node間の通信もVM組込み、もしくはSDKで強力にサポートしている。

型システム ::

  JVM     : bytecodeのverifierあり。静的。top-bottom, lattice
  Dart VM : 動的, 実行時の型をTypeFeedback
  BEAM VM : 動的, DataType ???


性能
*******************************************************************************

最大スループット ::

  JVM     : かなり速い
  Dart VM : 速い
  BEAM VM : 速さ優先じゃない

computer language benchmark games を参照してみるか。 JVMベースで評価するのがよいかな。


起動速度 ::

  JVM     : jarの解凍、ソースの読み込みが必要。
            client JIT, fibo(40), total 466ms, fibo 407ms, 起動に59ms
            server JIT, fibo(40), total 468ms, fibo 418ms, 起動に50ms
  Dart VM : scan済みのCoreLibをdeserializeするため、非常に高速
            fibo(40),total 423ms, fibo 402ms, 起動に21ms
  BEAM VM : 遅いかも。この辺はあまりがんばってないはず.


外部割り込みのソフトウェアリアルタイム性 ::

  JVM     :
  Dart VM :
  BEAM VM :

外部割り込みのレイテンシ ::

  JVM     :
  Dart VM : Isolate MailBox レイテンシ
  BEAM VM : async_main レイテンシ

信頼性
*******************************************************************************

何か信頼性の指標が、、

===============================================================================
===============================================================================
===============================================================================

JVMの特徴
*******************************************************************************

モノリシックで巨大なVM

単一のVMに巨大なHeapメモリを敷いて、スレッド大量に走らせて性能を稼ぐ。

Java向けにチューニングされており、特定のAPIは高速なMacroAssemblerに置換される。

マルチスレッドでの高速化をそうとう頑張っており、parallelなGC、Biased Locking、
ThreadLocalAllocationBufferなどなど。

Dart VMの特徴
*******************************************************************************

VM自体の最小メモリは40M程度。NewGenは32M、その他8Mくらい。

Main Isolateと子のIsolateを複数立てて、複数Isolateでシステムを構築する。

Isolate間に共有部分する部分は少なく、JIT, Heap, GC, ObjectStore, Codeを独立して内包する。

JVMとは異なりThreadは存在しない、shared nothingなIsolateを多数立てて、message passingで行う。

APIは非同期処理が大部分だが、非同期処理はVMでサポートせず、APIのレイヤーで吸収。

BEAM VMの特徴
*******************************************************************************

SMPに対応しており、インタプリタ実行するschedulerを8個立てる(core i7の場合)

AsyncはBEAMが専用のthreadに立てて、

スケジューラを独自実装、erlang processの独自実装

低レイテンシらしい。

Asyncは別threadを立ててそこで常時受ける。waitしながらasync eventがpushされるのを待つ。

なんでもVMの中に実装してる

SMP対応と、独自schedulerとGCおよびAsyncThreadのおかげで、大量のlock/unlockが挿入されている。

supervisorをVM内部に持つ。別threadを立ち上げておき、reqがあるまで寝ている。

supervisorは主にCodeIndexを使って、VM内のProcessの復帰処理を行うことができる。


VM KernelとUserSpace 間
===============================================================================

JVMとDart VMは、あまり頻繁にVM KernelとUserSpace間を行き来しないようにしている。
行き来はオーバーヘッドなので。。

具体的には、JVMは intrinsics を定義し、JITコンパイル時にはbypassして、MacroAssemblerに置換し、
JITコンパイルしたコードに、MacroAssemblerをそのまま埋め込むことが多い。

Dart VMもIntrinsicsのようなものを用意するが、こちらはRecognizerと読んでいる。
JITコンパイル時にRecognizerをIRに変換し、IRレベルで最適化、最終的にIRをemitしてアセンブラを生成。

