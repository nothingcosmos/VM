dart startup
###############################################################################

dartコマンドはmain

bin/main
*******************************************************************************

bin/main.cc ::

  Dart_Initialize()

  Dart_Isolate isolate = CreateIsolateAndSetupHelper()

    Dart_CreateIsolate() <-- init snapshot buffer
      Dart::InitializeIsolate(snapshot,)
    LoadAndCheckLibrary()
    LoadScript()

    Dart_ExitIsolate()
    Dart_IsolateMakeRunnable() //これで起動。
      iso->MakeRunnable()

  Dart_EnterIsolate(isolate)
  Dart_Invoke()
  Dart_RunLoop()
  
  // snapshot_buffer points to a snapshot if we link in a snapshot otherwise
  // it is initialized to NULL.
  extern const uint8_t* snapshot_buffer;
  bin/snapshot_inc.cc
  
  in building obj/gen/snapshot_gen.cc
  
  bin/snapshot_in.cc <-- make 
  
  generate_snapshot_file.host.mk
    runtime/tool/create_snapshot_file.py  input output inputbin
    input_bin = snapshot_gen.bin

vm/dart_api_impl.cc ::

  Dart_Initialize(snapshot)
    Dart::InitOnce()
      OS::InitOnce()
      VirtualMemory::InitOnce()
      Isolate::InitOnce()
      PortMap::IniOnce()
      FreeListElement::InitOnce()
      Api::InitOnce()
      CodeObservers::InitOnce()
      ThreadPool()
      ObjectStore::Init()

  Dart_CreateIsolate()
    Dart::CreateIsolate()
      Isoalte::Init()
    Dart::InitializeIsolate()

===============================================================================
===============================================================================
===============================================================================


Isolate::Init()
  new Isolate()
    main_port_
    heap_
    object_store_
    top_context_
    api_state_
    stub_code_

Dart::InitializeIsolate()
  or Obect::Init(Isolate)          <-- dart_no_snapshot
  Object::InitFromSnapshot(isolate) <-- dart
  // before print_bootstrap
    SnapshotReader reader(,,, kFull,
    reader.ReadFullSnapshot()

  Isolate initializetion 11455 - 81173 micros.
  Script Loading  50 -> 45183 micros.
  Bootstrap of core classes 28 - 81173 micros.
    object::init

  ---
  TIMERSCOPE

time_all: false (Time all functionality)
time_bootstrap: false (time_bootstrap)
time_compilation: false (time_compilation)
time_creating_snapshot: false (time_creating_snapshot)
time_isolate_initialization: false (time_isolate_initialization)
time_script_loading: false (time_script_loading)
time_total_runtime: false (time_total_runtime)
trace_runtime_calls: false (Trace runtime calls)
trace_type_check_elimination: false (Trace type check elimination at compile time.)
trace_type_checks: false (Trace runtime type checks.)
worker_timeout_millis: 5000 (Free workers when they have been idle for this amount of time.)




bin/gen_snapshot.cc
  LoadSnapshotCreationScript(app_script_name)
  CreateAndWriteSnapshot();
    Dart_CreateSnapshot()
      object_store()-set_root_library()
      FullSnapshotWrite()

core -> RawLibrary
  RawScript
    RawString
    RawTokenStream


TokenStream
