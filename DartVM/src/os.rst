runtime/vm
  debuginfo_android.cc
  gdbjit_android.h|cc
  os_android.cc
  virtual_memory_android.cc

runtime/platform
  utils_android.h|cc
  thread_android.h|cc

runtime/bin
  crypto_android.cc
  dbg_connection_android.h|cc
  directory_android.cc
  eventhandler_android.h|cc
  extensions_android.cc
  fdutils_android.cc
  file_android.cc
  platform_android.cc
  process_android.cc
  socket_android.h|cc
  utils_android.cc

runtime/vm/os.h
static const char* GetTimeZoneName(int64_t seconds_since_epoch);
static int GetTimeZoneOffsetInSeconds(int64_t seconds_since_epoch);
static int GetLocalTimeZoneAdjustmentInSeconds();
static int64_t GetCurrentTimeMillis();
static int64_t GetCurrentTimeMicros();
static word ActivationFrameAlignment();
static const int kMaxPreferredCodeAlignment = 32;
static word PreferredCodeAlignment();
static uword GetStackSizeLimit();
static int NumberOfAvailableProcessors();
static void Sleep(int64_t millis);
static void Print(const char* format, ...) PRINTF_ATTRIBUTE(1, 2);
static void PrintErr(const char* format, ...) PRINTF_ATTRIBUTE(1, 2);
static void VFPrint(FILE* stream, const char* format, va_list args);
static int SNPrint(char* str, size_t size, const char* format, ...) PRINTF_ATTRIBUTE(3, 4);
static int VSNPrint(char* str, size_t size, const char* format, va_list args);
static bool StringToInt64(const char* str, int64_t* value);
static void InitOnce();
static void Shutdown();
static void Abort();
static void Exit(int code);

runtime/bin
  crypto_android.cc
  dbg_connection_android.cc
  dbg_connection_android.h
  directory_android.cc
  eventhandler_android.cc
  eventhandler_android.h
  extensions_android.cc
  fdutils_android.cc
  file_android.cc
  platform_android.cc
  process_android.cc
  socket_android.cc
  socket_android.h
  utils_android.cc


localtime_r()
tzset()
gettimeofday()
getrlimit()
sysconf(_SC_NPROCESSORS_ONLN)
usleep()
vfprintf()
vsnprintf()
va_start()
va_end()
strtoll()
exit()

getpagesize()
mmap()
munmap()
unmap()
mprotect()
