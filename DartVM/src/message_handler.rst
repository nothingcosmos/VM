MessageHandler
###############################################################################

MessageHandlerを起動した際に、
callbackで IsolateMainを起動して、終了したらMessageHandlerを起動する

whileで回りながら、messageをdequeして
vm/isolate.cc
IsoalteMessageHandler::HandleMessage()

OOB(out-of-band) Deriver message asap

  void Run() {
      handler_->TaskCallback();
  }

HandleMessage()は
おそらくIsolateMessageHandler::HandleMessage()

  const Object& result = Object::Handle(
        DartLibraryCalls::HandleMessage(receive_port, msg));


Isolate
*******************************************************************************
Isolateが起動すると、
init済みのcallbackを呼び出してeventloopする。


isolateの起動 ::

  Isolate::MakeRunnable()
    mutex_->Lock();
    Run()
    mutex_->Unlock();

  void Isolate::Run() {
    message_handler()->Run(Dart::thread_pool(),
                           RunIsolate,
                           ShutdownIsolate,
                           reinterpret_cast<uword>(this));
  }


RunIsolate

//vm/message_handler.cc

  isolateがstartした後に、
  HandleMessages

*******************************************************************************

===============================================================================
===============================================================================
===============================================================================
===============================================================================

