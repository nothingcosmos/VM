async
===============================================================================

sample ::

  var f = new File(name).readAsLines();
  f.then((lines) => parse(lines));

sdk/lib/io/file.dart ::

  Future<List<String>> readAsLines([Encoding encoding = Encoding.UTF_8]);

sdk/lib/io/file_impl.dart ::

  Future<List<String>> readAsLines([Encoding encoding = Encoding.UTF_8]) {
    _ensureFileService();
    Completer<List<String>> completer = new Completer<List<String>>();
    return readAsBytes().then((bytes) {
      var decoder = _StringDecoders.decoder(encoding);
      decoder.write(bytes);
      return _getDecodedLines(decoder);
    });
  }

  Future<List<int>> readAsBytes() {
    _ensureFileService();
    Completer<List<int>> completer = new Completer<List<int>>();
    var chunks = new _BufferList();
    var stream = openInputStream();
    stream.onClosed = () {
      var result = chunks.readBytes(chunks.length);
      if (result == null) result = <int>[];
      completer.complete(result);
    };
    stream.onData = () {
      var chunk = stream.read();
      chunks.add(chunk);
    };
    stream.onError = (e) {
      completer.completeError(e);
    };
    return completer.future;
  }

streamのonClosed(), onData(), onError()

onClosedが呼ばれて、処理が完了したときcompleteに値をsetする。

onErrorで、completeError()にsetする。

onData()が呼ばれる限りは、addするだけ。


疑問点、、readAsLines()のcompleterは使っていないのでは？？？

もしかして、C++のObjectにbindingして、VM内部のHandle処理に影響を与えるのか？

Completer
===============================================================================
completerは、futureでgetするだけのはず。
そしてresultをcompleteで設定すると。

sdk/lib/async/future_impl.dart ::

  class _CompleterImpl {
    future = new _FutureImpl<T>();
    void complete(T value) {
      future._setValue(value);
    }

Completerはfutureのwarpperなだけだと思うけど、何かVMに作用するんだっけ？

Future
===============================================================================
Futureは、状態付き imcomplete, value, error

_FutureImplクラスが実体

factory wait()

then()

  stateを参照して、
  !_isCompleteの場合、 SubscribeToするだけ。
  でない場合、Errorを返すか、handleValueを返すか。



VMとの関連
===============================================================================
timerやstop_watchくらいかな。 とはいっても、OSのplatformの処理を呼ぶだけなんだろうけど。

何かweak referenceみたいなの使っているのだろうか。

時間を要求した場合、intのオブジェクトを作って返すくらいか。


vm/lib
===============================================================================
vm/lib/async ::

  event_loop_patch.dart
    class _AsyncRun
      _enqueueImmediate(void callback()) {
        Timer.run(callback);
      }
  timer_patch.dart
    class Timer
  deferred_load_patch.dart

Timer.run(void callback())
===============================================================================

_runCallbacks.add(callback)

length == 1 だったら、

new Timer(Duration(0), callback)

lib/timer_patch.dart _TimerFactory._factory()

class _TimerFactory {
  static _TimerFactoryClosure _factory;
}

どこ読んでるのかわからなかったけど、、sdk/lib/io/timer_impl.dart
ってなんだよ。。

_createTimer() {
  _EventHandler._start();
  if (_timers == null) {
    _timers = new DoubleLinkedQueue<_Timer>();
  }

_Timerを作ってかえす。

_EventHandler
_start()
_sendData()




その他
===============================================================================
関係あるのは、
bin/dartutils.cc::DartUtils::PrepareForScriptLoading()


AsyncRun {
}

future
===============================================================================

then sendValue


