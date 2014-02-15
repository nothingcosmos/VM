stream
###############################################################################

sdk/lib/async/stream
*******************************************************************************

isolate_patch.dart

StreamController



ReceivePortImpl
===============================================================================

extends Stream

StreamSubscription listen(void onData
  _controller.stream.listen()

final RawReceivePort _rawPort
StreamController _controller;

StreamController
===============================================================================

Stream<T> get stream;


listen
StreamSusscription
.onData
_onListen(subscription)



_onListenHandler = Zone.current.registerUnaryCallback(onListenHandler)



handle
===============================================================================

_handleMessage
schedule_microtask.dart::_asyncRunCallback
  _asyncRunCallbackLoop()
    _AsyncCallbackEntry entry = _nextCallback
    while(entry != null) {
      enry.callback();
      entry = _nextCallback = entry.next;
    }


_AsyncCallbackEntry next
_AsyncCallback callback



'deferred_load_patch.dart',
'schedule_microtask_patch.dart',
'timer_patch.dart',


class _AsyncRun {
  _scheduelImmediate(callback)
  //callback
}


_Timer

async Timer






===============================================================================
===============================================================================
===============================================================================
===============================================================================

*******************************************************************************
===============================================================================
===============================================================================
===============================================================================
