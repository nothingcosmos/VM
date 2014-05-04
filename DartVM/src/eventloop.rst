EventLoop
###############################################################################

eventhandler
*******************************************************************************

flags ::

  enum MessageFlags {
    kInEvent = 0,
    kOutEvent = 1,
    kErrorEvent = 2,
    kCloseEvent = 3,
    kDestroyedEvent = 4,
    kCloseCommand = 8,
    kShutdownReadCommand = 9,
    kShutdownWriteCommand = 10,
    kReturnTokenCommand = 11,
    kListeningSocket = 16,
    kPipe = 17,
  };

Dart_Port port_
int64_t timeout_

class EventHandler

void SendData(id, port, data) //native EventHandler_SendData
start
stop
delegate

class EventHandlerImplementation これがOSごとに実装

io_natives.cc
この中にnative symbolがある

linux impl
===============================================================================

実装されている関数一覧 ::

  void HandleEvents(struct epoll_event* events, int size);
  static void Poll(uword args);
  void WakeupHandler(intptr_t id, Dart_Port dart_port, int64_t data);
  void HandleInterruptFd();
  void SetPort(intptr_t fd, Dart_Port dart_port, intptr_t mask);
  intptr_t GetPollEvents(intptr_t events, SocketData* sd);
  static void* GetHashmapKeyFromFd(intptr_t fd);
  static uint32_t GetHashmapHashFromFd(intptr_t fd);

eventhnadlerでは、intptr_t fdからhashmapのkeyを生成している。

platform/hashmapってのが実装されている。

 int result = dart::Thread::Start(&EventHandlerImplementation::Poll,
                                    reinterpret_cast<uword>(handler));

epollを使用する

retryとかの制御はどうなっている？

NO_RETRY_EXPECTEDマクロで、EINTRまで繰り返す。


socketからのコントロール
===============================================================================

===============================================================================
===============================================================================
===============================================================================
===============================================================================

FileIO read
*******************************************************************************

create
===============================================================================

Future<File> create
_IOService.dispatch(_FILE_CREATE, [path]
.then((response)

io_natives

runtime/bin/io_service.h
にFILE_CREATE等に登録されている。

FILE_CREATE=1

#define IO_SERVICE_REQUEST_LIST(V)

File_Createに変換されてdispatchされている。

ListStart
ListNext
ListStopとか参考になるかも

class _IOService
===============================================================================

runtime/bin/io_service_patch.dart ::
  // Lazy initialize service ports, 32 per isolate.
  List<SendPort> _servicePort
  RawReceivePort _receivePort
  SendPort _replyToPort
  Map<int, Completer> _messageMap
  int _id

  Future dispatch(int request, List data)
  do {
    _getNextId()
  } while ()
  _servicePort[index].send([id, _replayToPort, request, data)
  //ここリストで渡してる

これを受信しているのは、IOServiceCallback
serviceごとにDart_portを開く。

::

  if (message->type == Dart_CObject_kArray &&
    request.Length() == 4 &&
    request[0]->IsInt32() &&
    request[1]->IsSendPort() &&
    request[2]->IsInt32() &&
    request[3]->IsArray()) {

sendのほうの細かい処理はisolateの中に実装。もしくはruntime

lib/isolate.cc
SendPortImpl_sendInternal
Messageを生成。port.Id(), data, writer.byteswirtten, priority


===============================================================================
===============================================================================
===============================================================================
===============================================================================
===============================================================================
IOService_NewServicePort
Dart_NewSendPort
isolate, SendPort::New(port_id)

send
sendto




class SendPort : public Instance
class RawSendPort


===============================================================================

template ::
  ###############################################################################
  *******************************************************************************
  ===============================================================================

