vmservice
###############################################################################

dart vm --enable-vm-service
default:localhost:8181


*******************************************************************************

main.cc
===============================================================================

::

  // VM Service options.
  // main.cc
  static bool start_vm_service = false;
  static int vm_service_server_port = -1;
  static const int DEFAULT_VM_SERVICE_SERVER_PORT = 8181;

  //dartコマンドのオプション
  dart options
  --enable-vm-service

  // main.cc
  // Start the VM service isolate, if necessary.
  if (start_vm_service) {
    bool r = VmService::Start(vm_service_server_port);
      Dart::Thread::Start(ThreadMain, server_port);


  // vmservice_impl.cc
  static const char* kVMServiceIOLibraryScriptResourceName =
      kLibraryResourceNamePrefix "/vmservice_io.dart";
  static const char* kVMServiceLibraryName =
      kLibraryResourceNamePrefix "/vmservice.dart";

  _Start()
    isolate_ = Dart_CreateIsolate("vmservice:", "main", ...);
    LoadScript(kVMServiceIOLibraryScriptResourceName);

vmservice_io
===============================================================================

いま風にhtmlで起動ですか。

::

  // Create VmService.
  var service = new VMService();
  // Start HTTP server.
  var server = new Server(service, _port);
  server.startServer();


VMService
===============================================================================

::

  _requestHandler(HttpRequest request)


  serviceRequest.parse()

  reqはmap形式、

  type
  msg
  pathSegments
  parameters

実験方法
===============================================================================

localhost:8181

へアクセス

/type

http://localhost:8181/?stacktrace=off


デバッグ情報を歯根でも上記までいかないということは、
途中でつまっているということ。

runtime/vm
===============================================================================

Future route(ServiceRequest request)
sendMessage(List request)
sendServiceMessage(sp, rp, m)
  native "SendServiceMessage";
