#!/bin/bash

unlock="-XX:+UnlockDiagnosticVMOptions"
asm="-XX:+PrintOptoAssembly"
#inline="-XX:MaxInlineSize=1 -XX:FreqInlineSize=1"
compile="-XX:+PrintCompilation -XX:+PrintInlining"
deopt="-XX:+TraceDeoptimization -XX:+DebugDeoptimization"

#base java -cp . DeserBenchmark 1700461846 10000000 1000

java -version
java -cp . -server -Xbatch $unlock $inline $asm $compile $deopt  DeserBenchmark 1700461846 10000000 100
java -version

