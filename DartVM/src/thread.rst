thread
###############################################################################

threadは主にthread_poolで管理している。

thread_poolは、dart.ccで定義されており、グローバル変数である。

::

  therad_pool = new ThreadPool() // dart.cc

dart.cc::Dart::InitOnce()で初期化する。

thread_poolは下記を定義している。

class ThreadPool, class ThreadPool::Task, class ThreadPool::Worker

thread_pool ::

  ThreadPool::Run(Task*)
  worker->SetTask(task);
  worker->StartThread();
    Thread::Start(&Worker::Main

runtime/platformディレクトリは、os依存の処理を定義している。

os依存の処理は、Thread, Mutex, Monitor等である。

# class Thread
## Start(function, parameters)  <-- これが一番使う
## DeleteThreadLocal
## GetThreadLocal
## SetThreadLocal

#class Mutex
## Lock()
## TryLock()
## Unlock()

#class Monitor
## Enter()
## Exit()


ThredPool::Run() Taskの一覧
*******************************************************************************

runtime/vm ::

  //message_handler
  MesssageHandlerTask : public ThreadPool::Task

  Isolate::Run()
    message_handler()->Run()

  //native_api_impl.cc native_message_handler
  Dart_NewNativePort()
    nmh = new NativeMessageHandler()
    nmh->Run(Dart::therad_pool()


runtime/lib/isolate.cc ::

  IsolateSpawnState()    //isolate.cc
      Isolate* child_isolate = reinterpret_cast<Isolate*>(
          (callback)(state->script_url(),
          state->function_name(),
          init_data,
          error));

  state->isolate->Run()  //runtime/vmのIsoalte::Run()
    void Isolate::Run() {
      message_handler()->Run(Dart::thread_pool(),
      RunIsolate,
      ShutdownIsolate,
      reinterpret_cast<uword>(this));
    }



state->isolate()->Run()で新規のスレッドを生成する。

内部では、message_handlerを別スレッドで生成し、Isolateの初期化およびStart処理を
callback登録して実行する。

isolateとmessagehandlerで2threadじゃなくて、
messagehandlerで立てる1threadだけ

threadはmessagehandlerで立てて、callbackする


runtime/bin ::

  dbg_connection_android.cc:  int result = dart::Thread::Start(&DebuggerConnectionImpl::Handler, 0);
  dbg_connection_linux.cc:  int result = dart::Thread::Start(&DebuggerConnectionImpl::Handler, 0);
  dbg_connection_macos.cc:  int result = dart::Thread::Start(&DebuggerConnectionImpl::Handler, 0);
  dbg_connection_win.cc:  int result = dart::Thread::Start(&DebuggerConnectionImpl::ThreadEntry, 0);
  eventhandler_android.cc:  int result = dart::Thread::Start(&EventHandlerImplementation::Poll,
  eventhandler_linux.cc:  int result = dart::Thread::Start(&EventHandlerImplementation::Poll,
  eventhandler_macos.cc:      dart::Thread::Start(&EventHandlerImplementation::EventHandlerEntry,
  eventhandler_win.cc:  int result = dart::Thread::Start(EventHandlerEntry,
  file_system_watcher_macos.cc:    Thread::Start(Run, reinterpret_cast<uword>(this));
  process_android.cc:    int result = dart::Thread::Start(ExitCodeHandlerEntry, 0);
  process_linux.cc:    int result = dart::Thread::Start(ExitCodeHandlerEntry, 0);
  process_macos.cc:    int result = dart::Thread::Start(ExitCodeHandlerEntry, 0);
  vmservice_impl.cc:    dart::Thread::Start(ThreadMain, server_port);


===============================================================================
===============================================================================
===============================================================================
