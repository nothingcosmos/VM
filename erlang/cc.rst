erl call chaing
###############################################################################

ex) ::

  $ erl -noshell -smp disable -run hello start -run init stop
  $ erl -noshell -run hello start -s init stop

build時にはbeamとbeam.smpの2種類があり、#ifdef ERTS_SMP で2つビルドしている。

-smp disableでbeamが起動する。デフォルトは-smp=core数で起動、ERTS_SMPをマクロ定義

pthread created
*******************************************************************************

beam内では、すべてerts_thr_create()を使ってpthreadを生成する。

symbols ::

  signal_dispatcher_thread_func
  sys_msg_dispatcher_func
  async_main * 10
  child_waiter
  sched_thread_func * 8
  aux_thread

  runq_supervisor //デフォルトでは起動しない


BEAM VMのmainプログラム
===============================================================================

::

  ./erlexec.c
      int main(int argc, char **argv)
  ...
      // linuxのexecv で起動する
      execv(emu, Eargsp);   //int execv(const char *path, char *const argv[]);


  ./erts/emulator/sys/unix/erl_main.c  //unix版の起動プロセス
  sys/unix/erl_main.c:29
  24  #include "global.h"
  25
  26  int
  27  main(int argc, char **argv)
  28  {
  29      erl_start(argc, argv);
  30      return 0;
  31  }


  erl_start (argc=10, argv=0xbfffe804) at beam/erl_init.c:923
  921 void
  922 erl_start(int argc, char **argv)
  923 {
  ...
  929     int ncpu = early_init(&argc, argv); //create 1thread
              erl_sys_args()
                  init_smp_sig_notifl()
                      erts_smp_thr_create(&sig_dispatcher_tid, signal_dispatcher_thread_func,
  ...
  1677      erl_init(ncpu,                    //create 12thread, smp disableの場合はもっと少ない。
  1678         proc_tab_sz,
  1679         legacy_proc_tab,
  1680         port_tab_sz,
  1681         port_tab_sz_ignore_files,
  1682         legacy_port_tab);
                erts_init_trace()
                    erts_smp_thr_create(&sys_msg_dispatcher_tid, sys_msg_dispatcher_func,
                ...
                erts_init_async()
                    erts_thr_create(&aq->thr_id, async_main, (void*) aq, &thr_opts);
                erts_init_io()
                    spawn_driver_entry に関数ポインタのentry table
                        spawn_init()
                            erts_thr_create(&child_waiter_tid, child_waiter, NULL, &thr_opts);
  ...
  1690     erl_first_process_otp("otp_ring0", NULL, 0, boot_argc, boot_argv);
  1691
  1692 #ifdef ERTS_SMP
  1693      erts_start_schedulers();          //create 9thread, 1 + smpで合計9, call ethr_thr_create()
  1694     /* Let system specific code decide what to do with the main thread... */
  1695
  1696      erts_sys_main_thread(); /* May or may not return! */  //start erlshell
  ...
  1702 #endif
  1703     set_main_stack_size();
  1704     process_main();
  1705 #endif


  5811 void
  5812 erts_start_schedulers(void)
  5813 {
  ...
  5822 #ifdef ERTS_SMP
  5823     if (erts_runq_supervision_interval) {
  5824         opts.suggested_stack_size = 16;
  5825         erts_atomic_init_nob(&runq_supervisor_sleeping, 0);
  5826         if (0 != ethr_event_init(&runq_supervision_event))
  5827             erl_exit(1, "Failed to create run-queue supervision event\n");
  5828         if (0 != ethr_thr_create(&runq_supervisor_tid,
  5829                                  runq_supervisor,
  5830                                  NULL,
  5831                                  &opts))
  ...
  5846     while (actual < wanted) {
  5847         ErtsSchedulerData *esdp = ERTS_SCHEDULER_IX(actual);
  5848         actual++;
  5850         res = ethr_thr_create(&esdp->tid,sched_thread_func,(void*)esdp,&opts);
  5854         }
  5855     }
  ...
  5861     res = ethr_thr_create(&aux_tid, aux_thread, NULL, &opts);


  Breakpoint 1, erts_sys_main_thread () at sys/unix/sys.c:2966
  2964  void
  2965  erts_sys_main_thread(void)
  2966  {
  ...
  3003    (void)
  3005        select(0, NULL, NULL, NULL, NULL);

  メッセージ受信してやらかすらしい。


::

  //system callのpthread_create()でthr_wrapperを起動。第3引数
  erts/lib_src/pthread/ethread.c
  286 int
  287 ethr_thr_create(ethr_tid *tid, void * (*func)(void *), void *arg,
  288                 ethr_thr_opts *opts)
  289 {
  ...
  367     res = pthread_create((pthread_t *) tid, &attr, thr_wrapper, (void*) &twd);


   82 static void *thr_wrapper(void *vtwd)
   83 {
   ...
   87     void *(*thr_func)(void *) = twd->thr_func;
   ...
  104     ethr_event_set(&tsep->event);
  105
  106     res = result == 0 ? (*thr_func)(arg) : NULL;  //関数ポインタでsched_thread_funcを呼び出す
  107
  108     thr_exit_cleanup();
  109     return res;
  110 }


  // pthread_create()でthread作成後、(thr_wrapperはsched_thread_funcの関数ポインタ)
  //process_main()を起動する。
  #2  0x080db63d in sched_thread_func (vesdp=0xb6e76f80) at beam/erl_process.c:5801
  5722 static void *
  5723 sched_thread_func(void *vesdp)
  5724 {
  ...
  5800
  5801     process_main();                                  //ここがキモ
  5802     /* No schedulers should *ever* terminate */
  5803     erl_exit(ERTS_ABORT_EXIT,
  5804              "Scheduler thread number %beu terminated\n",
  5805              no);
  5806     return NULL;
  5807 }

erlangのerl_processのメインループ

::

  Breakpoint 1, process_main () at beam/beam_emu.c:1081
  1081  {
  1171      if (!init_done) {
  ...
  1197     ERTS_VERIFY_UNUSED_TEMP_ALLOC(c_p);
  1198     c_p = schedule(c_p, reds_used);           //scheduleはインタプリタ
  1199     ERTS_VERIFY_UNUSED_TEMP_ALLOC(c_p);
  ...


  schedule (p=0x0, calls=0) at beam/erl_process.c:6765
  6760   * We reschedule low prio processes a certain number of times 
  6761   * so that normal processes get to run more frequently. 
  6762   */
  6763
  6764  Process *schedule(Process *p, int calls)
  6765  {
  ...
  7017        scheduler_wait(&fcalls, esdp, rq);    //hello world


  Breakpoint 2, scheduler_wait at beam/erl_process.c:2288
  2286  static void
  2287  scheduler_wait(int *fcalls, ErtsSchedulerData *esdp, ErtsRunQueue *rq)
  2288  {
  ...
  2343      erts_thr_progress_prepare_wait(esdp);   //nest call scheduler_wait()
  ...
  2385    sched_active(esdp->no, rq);


  scheduler_waitから戻ってきたのかも。
  beam/beam_emu.c::process_main()
  ...
  1205      PROCESS_MAIN_CHK_LOCKS(c_p);
  ...

  process_main()が全opcodeのインタプリタ兼context switchになっているみたい。


BEAM VM
*******************************************************************************


emulator OpCase
===============================================================================

int同士の加算

::

  OpCase(i_plus_jId):

    if (is_both_small(tmp_arg1, tmp_arg2)) {
      Sint i = signed_val(tmp_arg1) + signed_val(tmp_arg2);
      if (MY_IS_SSMALL(i)) {
        result = make_small(i);
        STORE_ARITH_RESULT(result);
      }
    }
    arith_func = ARITH_FUNC(mixed_plus);
    goto do_big_arith2;

tmp_arg1 と tmp_arg2 がどちらもsmallだったら、 signed_val()した値を + で加算する。

加算結果がSMALLだったら、STORE


breakpoint memo
*******************************************************************************

::

  main

  process_main 8th

  scheduler_wait

::

  $ break process_main
  $ run -noshell -smp disable -run hello start -run init stop
  $ c
  $ c

-smp disableだとbeamのほうを起動する。-smp 2くらいでbeam.smpがよいかも
