BEAM VM Source Code Reading
###############################################################################

otp_src_R16B01 を対象

erts/emulator/beam を中心に読む。

Runtime System Overview
*******************************************************************************

Runtime system ::

  HiPE compiler (Erlang)
  Mode switch Beam/HiPE (asm)
  Glue code for bif calls (m4 macro)
  Garbage collection (C)
  Stubs for BEAM calls (C and asm)
  Loader (C and Erlang)
  Signal stack handling (C)
  Arithmetic overflow (asm and C)


実行の仕組み
===============================================================================

bin ::

 $ configure
 $ make

 $ cd bin
 $ ls
 cerl    dialyzer  erlc     i686-pc-linux-gnu  start.script      start_clean.script  start_sasl.script
 ct_run  erl       escript  start.boot         start_clean.boot  start_sasl.boot     typer

 $ cd i686-pc-linux-gnu
 $ ls
 beam      child_setup  dialyzer  epmd  erlexec  heart            hipe_mkliterals.smp  run_erl  typer
 beam.smp  ct_run       dyn_erl   erlc  escript  hipe_mkliterals  inet_gethost         to_erl


erlang commands
===============================================================================
hello worldをコマンドラインから実行する。

::

  $ erlc hello.erl
  $ erl -noshell -s hello start -s init stop

  $ cat erl
  ROOTDIR="xxx/otp_src_R16B01"
  BINDIR=$ROOTDIR/bin/i686-pc-linux-gnu
  EMU=beam
  PROGNAME=`echo $0 | sed 's/.*\///'`
  export EMU
  export ROOTDIR
  export BINDIR
  export PROGNAME
  exec "$BINDIR/erlexec" ${1+"$@"}


erlコマンドは、ただのshellでerlexecを読んでいる。

erlcでhello.erlをbeam vm用のbytecodeにコンパイル

initialize
*******************************************************************************

callchain ::

  main
    erl_start
      erl_init                    //10 thread start
        erl_init系を大量起動
      erl_first_process_otp("otp_ring0"
        erl_create_process
      erts_start_schedulers
      erts_sys_main_thread
        select //ここでblocking

  ethr_thr_create
    pthread_create          //system call

pthread_createでprocess_mainを生成。process_mainは、scheduler and interpreter
OS thread1 : process_main

call chain ::

  sched_thread_func
    process_main
      schedule
        schedule_wait


erl process
*******************************************************************************

spawn()によって Eterm erl_create_process()

erlangの関数は、全部BIF系で定義されている。 下記3つでerl_create_process()が呼ばれる。

erts/emulator/beam/bif.c ::

  BIF_RETTYPE spawn_3()
  BIF_RETTYPE spawn_link_3()
  BIF_RETTYPE spawn_opt_1()

  Eterm
  erl_create_process(Process* parent, /* Parent of process (default group leader). */
                     Eterm mod,   /* Tagged atom for module. */
                     Eterm func,  /* Tagged atom for function. */
                     Eterm args,  /* Arguments for function (must be well-formed list). */
                     ErlSpawnOpts* so) /* Options for spawn. */
  ...
  erts_smp_proc_lock(parent, )
  ...
  p = alloc_process(rq, state);     //(1)
  ...
  p->schedule_count = 0;
  p->initial[INITIAL_MOD] = mod;
  p->initial[INITIAL_FUN] = func;
  p->initial[INITIAL_ARI] = (Uint) arity;
  ...
  ret = erts_add_link()
  erts_make_ref()
  erts_add_monitor()
  ...
  erts_smp_proc_unlock(p, )
  schedule_process(p, state, 0)     //(2)


ポイントはallocとschedule_process かな

alloc_process() ::

  alloc_process()
    p = erts_alloc_fnf()
    ...
    erts_ptab_new_element()   //ptab -> Process/Port table

  アロケータは関数ポインタのテーブルで呼び出しているので追いがたい
  erl_alloc.h erts_allctrs[ERTS_ALC_T2A(type)].alloc

  emulator/sys/xxx/sys.cにOS依存で分けられている。
  erts_sys_alloc   unixの場合はmalloc
  erts_sys_realloc unixの場合はrealloc
  erts_sys_free    unixの場合はfree

processの生成には malloc/freeを使うらしい。

schedule_process(p, ...) ::


GC
*******************************************************************************

gc系の起点 ::

  erts_init_gc()

  erts_garbage_collect(Process*, ...)
    if (F_NEED_FULLSWEEP)
      major_collection()
    else
      minor_collection()

  minor_collection(Process*, ...)
    minor_collection()

  erts_garbage_collect_hibernate(Process* p)
    old_heap
      sweep_rootset()
      sweep_one_area()

  erts_garbage_collect_literals(Process*, Eterm*, ...)
    sweep_one_heap()
    sweep_one_area()

  hibernateとliteralsの違いがよくわからん。。


gcを呼び出す起点

erts_garbage_collectを呼び出すマクロ一覧 ::

  beam_emu.c
    AH
    TestBinVHeap
    TestHeap
    TestHeapPreserve

  bif.c
    garbage_collect_1()
    garbage_collect_0()

  erl_arigh.c
    erts_gc_mixed_plus()
    erts_gc_mixed_minus()
    erts_gc_mixed_times()
    erts_gc_int_div()
    erts_gc_int_rem()

  heapのneededより少なくなったらGCするって、CopyGCなんだっけ。

  HEAP_LIMIT, HEAP_TOP

  ERTS_NEED_GC
  #define ERTS_NEED_GC(p, need) ((HEAP_LIMIT((p)) - HEAP_TOP((p))) <= (need))

http://cooldaemon.tumblr.com/post/20826850272/erlang-gc
===============================================================================

Erlang GC メモ ::

  プロセス同士が共有メモリを持たないのでプロセス毎に GC を持つ事が可能(Incremental GC)
  プロセスが終了したら、難しい事を何も考えずに即時 Heap が解放される
  メモリを大量消費する処理をプロセスに閉じ込めるという戦略が有効(終了 = 解放)
  Heap が拡張されるサイズは、0,1 が固定値で、2 - 22  回までフィボナッチ数列、
  23 回以降は 5*(一つ前のサイズ/4)
    >> erts_init_gc()で調整している。
      [0] = 12
      [1] = 38
      [2] ~ [22]は、heap_sizez[-1] + heap_sizes[i-2] + 1;

      [23]以降は、20% growthモード
      heap_size[i] = heap_sizes[i-1] + heap[i-1]/5;

      以降はどんどんgrowthしていくけど、最大値が決まっている。
      32bitモードの場合、max(32bit)/4, 64bitモードの場合、max(52bit) / 8

      上記の数値は、heap_size * word_size分のメモリを確保する。

  receive 等でプロセスが中断すると GC も止まる
  プロセスが中断していても erlang:hibernate/3 で GC を強要できる
    >> erts_garbage_collect_hibernate()が呼ばれるのかな。

  spawn_opt でプロセス起動時の Heap を調整できる
  プロセスが終了間際に 200K の Heap を持っていると解っているなら、
  始めから 200K にしておくと Heap を増やす負荷を下げられる
  プロセス起動時は Compacting GC (本当か?)
  プロセスが確保している Heap が大きくなると Generational GC に切り替わる (境目はどこだ?)
  64 バイトを超えるバイナリデータは、Heap の外で Reference Counter によって管理
  バイナリに他のデータの参照を含められるので、Reference Counter でも循環参照は起きない
  ETS テーブル自体は Reference Counter で管理
  ETS テーブルを所有するプロセスは、ets:new/2 したプロセス一つのみ
  ETS を所有するプロセスが終了すると、ETS テーブルは消える
  ETS のレコードを参照すると、Heap にコピーされる
  ETS のレコードが大きい場合でも大丈夫という話しを見かけたが、何故か理由が解らない
  Atom は、Heap とは切り離されたデータ領域に保存されている
  Atom はプロセス間で共有されており、GC の対象外
  dbg モジュールの知識必須(後で詳しく調べる)

上記を読むと、erlang GCは世代別GCで、

new_heap はmark&sweep, old_heapはmark&sweep

new_heapはgrowthしていく。

いあ、incremental compaction



message passing
*******************************************************************************

serialize/deserialize と呼ばずに、Encode/Decode

messageは、おそらく struct erl_mesg -> ErlMessage

process構造体が、ErlMessageQueue msg; を持つ。


::

  do_send()
    remote_send() //Process *p, DistEntry *dep, Eterm to, Eterm msg,
      erts_dsig_send_req_msg()
        dsig_send()
      erts_dsig_send_msg()
        dsig_send()
    ...

    lock
    //send to local process
    res = erts_send_message() //Process* sender, receiver, Eterm message
      res = queue_message() //ここはまだ追ってない
    unlock


  dsig_send() //ErtsDSigData *dsdp, Eterm msg
    erts_encode_dist_ext(msg, 

  // encodeのメイン処理
  erts_encode_dist_ext(msg, 
    erl_term()
      enc_term_int() //ここ以降は全部externalに記述


messageをローカルで飛ばす場合、lock/unlockして転送するのみ。

外部にmessageを飛ばす場合、encode/decodeする。external領域にメモリアロケーション。


async_main
*******************************************************************************

Asyncの処理は、threadを10個立てて個別に処理

async_main関数をthread並列で実行する。

erts_thr_create(&aq->thr_id, async_main, (void*) aq, &thr_opts);


::

  static void *async_main(void* arg)
  {
  ...
    while(1) {
      ErtsThrQPrepEnQ_t *prep_enq;
      ErtsAsync *a = async_get(&aq->thr_q, tse, &prep_enq);
      if () break;

      a->async_invoke(a->async_data);
      async_reply(a, preq_enq)
    }
  }
  // async_invokeを実行、引数はasync_data

  //async_getでwaitしながら待つ
  async_get(ErtsThrQ_t *q, erts_tse_t *tse, ErtsThrQPreqEnQ_t **prep_enq) {
    while (1) {
      ErtsAsync *a = erts_thr_q_dequeue(q)

      ...
      erts_tse_wait(tse);

  struct _erl_async {
    void (*async_invoke)(void*);


run_queue
*******************************************************************************

run_queueも分割されてSMP対応しているのか？

::

  typedef unsigned int Eterm;

  struct process
    erts_smp_atomic_t run_queue;

  struct ErtsSchedulerData_
    ErtsRunQueue run_queue;

  struct _erl_drv_port
    erts_smp_atomic_t run_queue;

fault tolerant
*******************************************************************************

supervisorにお任せ

supervisorは別threadで起動している。

::

  runq_supervisor()
    while (1) {
      erts_milli_sleep()
      while (1) {
        ethr_event_reset(&runq_supervision_event)
        no_runqs_to_supervise()
          break
        ethr_event_wait()
      }
      for (ix ...
        EtrtsRunQueue *rq = ERTS_RUNQ_IX(ix)
        wake_schedule_on_empty_runq(rq)
          ...
            ...
              wake_scheduler()
    }


code_index って

===============================================================================
===============================================================================
===============================================================================
