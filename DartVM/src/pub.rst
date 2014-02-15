export PATH=dart-sdk/bin

pub installの前後
===============================================================================

elise@elise-desktop:~/language/dart$ cd benchmark_harness/
README.md  example  lib  pubspec.yaml

elise@elise-desktop:~/language/dart/benchmark_harness$ pub install
Resolving dependencies...
Dependencies installed!
elise@elise-desktop:~/language/dart/benchmark_harness$ ls
README.md  example  lib  packages  pubspec.lock  pubspec.yaml

dart Benchmark
===============================================================================

elise@elise-desktop:~/language/dart/benchmark_harness/example$ dart DeltaBlue.dart 
DeltaBlue(RunTime): 2728.512960436562 us.

elise@elise-desktop:~/language/dart/benchmark_harness/example$ dart Template.dart 
Template(RunTime): 0.5470164764097777 us.

elise@elise-desktop:~/language/dart/benchmark_harness/example$ dart Richards.dart 
Richards(RunTime): 2212.3893805309735 us.

