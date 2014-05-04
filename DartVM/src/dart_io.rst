
src ::

  parentDir.list(recursive: true).where((FileSystemEntity entity) => FileSystemEntity.isFileSync(entity.path))
    .listen((FileSystemEntity entity) {
      SHA1 sha1Hash = new SHA1();
      new File(entity.path)..openRead().take(10).listen((List<int> readData) {
        sha1Hash.add(readData);


sdk/lib/io/file_impl.dart ::

  Stream<List<int>> openRead([int start, int end]) {
    return new _FileStream(path, start, end);
  }

class _FileStream extends Stream<List<int>> { ::

  // Stream controller.
  StreamController<List<int>> _controller;

  // Information about the underlying file.
  String _path;
  RandomAccessFile _openedFile;
  int _position;
  int _end;
  final Completer _closeCompleter = new Completer();

  // Has the stream been paused or unsubscribed?
  bool _paused = false;
  bool _unsubscribed = false;

  // Is there a read currently in progress?
  bool _readInProgress = false;
  bool _closed = false;

  // Block read but not yet send because stream is paused.
  List<int> _currentBlock;


  // ここから適当に
  new BytesBuilder()
  List<int> readSync(int bytes)
    external static _read()

  //view
  _makeUint8ListView

  readに関してはFileIO




