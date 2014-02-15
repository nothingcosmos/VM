isolateの以下の基本的なメッセージパッシング処理

send()
receive()

SendPortImpl_sendInternal_()
===============================================================================
runtime/lib/isoalte.cc
MessageWriter に、送付するobjを書き込む。

PortMap::PostMessage(new Message(send_id.Value(), re
data, writer.BytesWritten(), <-- 最終的にはBytesWritten()してから送付

送受信の型は、Message

MessageHnadler::PostMessage()
MonitorLocker ml()
oob_queue Enqueue(message)
queue  Enqueue(message)

oobはout-of-band
緊急時のメッセージ
erlangやtcp/ipで使われる。

ThreadPoolを使って
task_ = new MessageHAndlerTask(this)
pool_->Run(task_)

Runは、Message:Handler::Run(ThreadPool*, Startcallback, EndCallback, CallbackData)

HandleMessageクラスが、PortMapを管理するらしい。


receive
===============================================================================
runtime/lib/isolate_patch.dart

receive(void onMessage(var message, SendPort replyTo)) {
  _onMessage = onMessage;
}

receiveで登録された、callback関数messageを _handleMessage経由で呼び出す。
static void _handleMessage(int id, int replyId, var mesasge) {
  (port._onMessage)(message, replyTo);
}

_handleMessageは、DartVM側から呼び出される。
DartLibraryCalls::HandleMessage()が該当
const Instance& mesage
最後にInvokeStaticで呼び出す。


メッセージの受け渡しは、message_handlerに記述されてそう。

handler
===============================================================================
HandleMessages()
Message* message = DequeueMessage()
HandleMessage(message); <-- isolate.cc HnadleMesage(Message*)

isolate.cc::HnadleMesage(Message*)
snapshot reader(Snapshot::kMessage)

readerで、Instance型にデシリアライズ

HandleMirrorsMessage() <-- unimple
DartLibraryCalls::HandleMessage() <-- これでlibcall

Message
===============================================================================





実装
===============================================================================
isolate自体は、
VMが1プロセスで、isolateはthreadなのかな。

Completer
Future
isolate.spawnFunction(childIsolate);
nativeらしい。

native isolate_spawnFunction(Instance, closure, Arguments->At(0)
native isolate_spawnUri
  Function& func = closure
  return Spawn(arguments, new SpawnState(func));

Spawn
  CreateIsolate(state, &error)

CreateIsolate()
  Dart_IsolateCreateCallback callback = Isolate::CreateCallback();
  void* init_data = parent_isolate->init_callback_data();
  bool retval = (callback)(state->scrip_url(), state->function_name(), init_data, error);

callbackは、

Dart_InitOnce(create, inturrupt, shutdown)
PS::InitOnce();
VirtualMemory::
Isolate::
PortMap::
FreeListElement::
Api::
thread_pool = new ThreadPool()
{
  mv_isolate_ = Isolate::Init("vm-isolate");
}

isolate間のswitchはどうやって行うんだ？






isolate switch



thread.h
lock
MutexLocker
MonitorLocker




ためしに、isolateを10個並列に行って
CPUの使用率を見てみるか？

基本はthreadだけど。




newgen=32
oldgen=512
83個目でsegvした。

newgen=3   <--
newgen=32  <-- 83 segv
newgen=128 <-- 21 segv
newgen=512 <--  3 segv

timer
===============================================================================

TimerFactoryClosure




EventTime
===============================================================================

if (is_runnable()) {
  ScheduleInterrupts(Isolate::kVmStatusInterrupt);
  {
    ...
  }
  SetVmStatsCallback(NULL);
}


Isolate
===============================================================================

stateでisolateの初期化を行った後に呼び出す。

Run ::

  //vm/isolate.cc
  void Isolate::Run() {
    message_handler()->Run(Dart::thread_pool(), RunIsolate, ShutdownIsolate,
                           reinterpret_cast<uword>(this));
  }

  //vm/message_handler.cc
  void MessageHandler::Run(ThreadPool* pool,
                           StartCallback start_callback,
                           EndCallback end_callback,
                           CallbackData data) {
      MonitorLocker ml(&monitor_);
      pool_ = pool;
      start_callback_ = start_callback;
      end_callback_ = end_callback;
      callback_data_ = data;
      task_ = new MessageHandlerTask(this);
      pool_->Run(task_);
  }


  Pool Run
  //vm/thread_pool.cc
  void ThreadPool::Run(Task* task) {
    Worker* worker = NULL;
    ...
    worker = new Worker(this);
    ...
    worker->SetTask(task);
    if (new_worker) {
      // Call StartThread after we've assigned the first task.
      worker->StartThread();
          int result = Thread::Start(&Worker::Main, reinterpret_cast<uword>(this));
    }

  //vm/thread_pool.cc
  class Worker {
     public:
       explicit Worker(ThreadPool* pool);

       // Sets a task on the worker.
       void SetTask(Task* task);

       // Starts the thread for the worker.  This should only be called
       // after a task has been set by the initial call to SetTask().
       void StartThread();

       // Main loop for a worker.
       void Loop();

       // Causes worker to terminate eventually.
       void Shutdown();

    //private field
    // Fields owned by Worker.
    Monitor monitor_;
    ThreadPool* pool_;
    Task* task_;


  //vm/message_handler.cc
  void MessageHandler::TaskCallback() {
    ...
    if (start_callback_) {
      monitor_.Exit();
      ok = start_callback_(callback_data_);
      start_callback_ = NULL;
      monitor_.Enter();
    }
    ...
    ok = HandleMessages(true, true);

  //vm/message_handler.cc
  //HandleMessageの中でwhileループしながら
  //trace-isolatesオプション
  HandleMessages() {
    ...
    while (message) {
      // Release the monitor_ temporarily while we handle the message.
      // The monitor was acquired in MessageHandler::TaskCallback().
      monitor_.Exit();
      Message::Priority saved_priority = message->priority();

      //vm/native_message_handler.cc
      result = HandleMessage(message);
          // Enter a native scope for handling the message. This will create a
          // zone for allocating the objects for decoding the message.
          ApiNativeScope scope;
          ApiMessageReader reader(message->data(), message->len(), zone_allocator);
          Dart_CObject* object = reader.ReadMessage();
              //func Dart_NativeMessageHandler func
          (*func())(message->dest_port(), object);
          delete message;
          return true;

      monitor_.Enter();
      if (!result) {
        // If we hit an error, we're done processing messages.
        break;
      }
      if (!allow_multiple_normal_messages &&
        saved_priority == Message::kNormalPriority) {
        // Some callers want to process only one normal message and then quit.
        break;
      }
      message = DequeueMessage(min_priority);
    }


概要にまとめると、

message handlerの起動
  start thread
    callbackでisolateを起動する
    isolateが終わったら,message handlerでひたすらwhile wait







どこでzoneのループするのか。




portの作成
===============================================================================
ReceivePort

lib/isolat_patch.dart
class _RawReceivePortImpl implements RawReceivePort
  native "RawReceivePortImpl_factory
  native "RawReceivePortImpl_closeInternal

nativeはlib/isolate.ccに定義


DEFINE_NATIVE_ENTRY(RawReceivePortImpl_factory, 1) {
  Dart_Port port_id = PortMap::CreatePort(arguments->isolate()->message_handler());
  const Object& port = Object::Handle(ReceivePortCreate(port_id));


vm/port.cc PortMap

Entry entry;
entry.port = AllocatePort();
entry.handler = handler;
entry.live = false;

map_[index] = entry //ここでmap_に設定。

PortMap {
  static Entry* map_; //ここにmaping

PortMap::Entry ::

  // Mapping between port numbers and handlers.
  //
  // Free entries have id == 0 and handler == NULL. Deleted entries
  // have id == 0 and handler == deleted_entry_.
  typedef struct {
    Dart_Port port;
    MessageHandler* handler;
    bool live;
  } Entry;




===============================================================================
