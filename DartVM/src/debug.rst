debugging
###############################################################################
assert時にbreakしてデバッグを開始するためには

break dart::Assert

===============================================================================
===============================================================================
===============================================================================
===============================================================================
===============================================================================

===============================================================================

--verbose-gc=true  を実行し、mark&sweepが多く出すぎ たぶんGCが原因でしょと。

--print-object-histogramを実行し、あまり多くのオブジェクトが占有していないことを確認。
--print-object-histogramはnew/oldでそれぞれカウントしてほしいけど、統計みたいなもんだし難しいか。


--verbose-gcの結果をcalcに張り付けてみる


理由に関して
full, new space, promotion failure
他にあるか?
new space, promotion failure, old space, full, debugging, test case


[    GC    |  space  | count | start | gc time | new gen (KB) | old gen (KB) | timers | data ]
[ (isolate)| (reason)|       |  (s)  |   (ms)  |  used , cap  |  used , cap  |  (ms)  |      ]
[ GC(7113): Scavenge(full), 1, 0.610, 0.707, 2602, 221, 32768, 32768, 2049, 2049, 2116, 2116, 0.517, 0.659, 0.529, 0.502, 807, 807, 0, 0, ]
[ GC(7113): Mark-Sweep(full), 2, 0.610, 2.223, 221, 221, 32768, 32768, 2049, 1754, 2116, 2116, 1.958, 0.500, 0.764, 0.500, 14, 0, 0, 0, ]
[ GC(7113): Scavenge(new space), 3, 0.806, 0.898, 16384, 516, 32768, 32768, 1877, 2088, 2116, 2372, 0.516, 0.711, 0.667, 0.502, 813, 813, 0, 0, ]
[ GC(7113): Mark-Sweep(promotion failure), 4, 0.806, 2.488, 516, 516, 32768, 32768, 2088, 1998, 2372, 2372, 2.288, 0.501, 0.698, 0.500, 4, 1, 1, 4, ]
[ GC(7113): Scavenge(new space), 5, 1.001, 0.673, 16384, 515, 32768, 32768, 2085, 2088, 2372, 2372, 0.511, 0.514, 0.644, 0.503, 57, 57, 0, 0, ]
[ GC(7113): Scavenge(new space), 6, 1.174, 0.662, 16384, 513, 32768, 32768, 2107, 2109, 2372, 2372, 0.510, 0.509, 0.639, 0.503, 16, 16, 0, 0, ]
[ GC(7113): Scavenge(new space), 7, 1.366, 0.527, 16374, 10, 32768, 32768, 2169, 2170, 2372, 2372, 0.512, 0.507, 0.505, 0.503, 11, 11, 0, 0, ]
[ GC(7113): Scavenge(new space), 8, 1.539, 0.667, 16384, 513, 32768, 32768, 2199, 2201, 2372, 2372, 0.510, 0.507, 0.647, 0.502, 20, 20, 0, 0, ]
[ GC(7113): Scavenge(new space), 9, 1.711, 0.525, 16384, 1, 32768, 32768, 2736, 2737, 2888, 2888, 0.512, 0.506, 0.503, 0.503, 21, 21, 0, 0, ]
[ GC(7113): Scavenge(new space), 10, 1.900, 0.522, 16384, 1, 32768, 32768, 3249, 3249, 3404, 3404, 0.512, 0.504, 0.502, 0.503, 9, 9, 0, 0, ]
[ GC(7113): Scavenge(new space), 11, 2.107, 0.685, 16384, 513, 32768, 32768, 3272, 3272, 3404, 3404, 0.514, 0.503, 0.664, 0.503, 11, 11, 0, 0, ]
[ GC(7113): Scavenge(new space), 12, 2.283, 0.663, 16384, 513, 32768, 32768, 3291, 3291, 3404, 3404, 0.512, 0.505, 0.642, 0.503, 13, 13, 0, 0, ]
[ GC(7113): Scavenge(full), 13, 2.462, 0.584, 16301, 257, 32768, 32768, 3310, 3310, 3404, 3404, 0.510, 0.503, 0.568, 0.502, 8, 8, 0, 0, ]
[ GC(7113): Mark-Sweep(full), 14, 2.462, 2.523, 257, 257, 32768, 32768, 3310, 2040, 3404, 2372, 2.242, 0.501, 0.719, 0.560, 38, 0, 0, 0, ]
[ GC(7113): Scavenge(new space), 15, 2.648, 0.660, 16384, 513, 32768, 32768, 2552, 2552, 2888, 2888, 0.511, 0.503, 0.642, 0.503, 5, 5, 0, 0, ]
[ GC(7113): Scavenge(new space), 16, 2.820, 0.584, 16384, 257, 32768, 32768, 2574, 2574, 2888, 2888, 0.513, 0.503, 0.563, 0.503, 9, 9, 0, 0, ]

[ GC(7113): Scavenge(full),
  17, //count
  2.830, //start time
  0.608, //total time
  575, 4, 32768, 32768,   //newgen(KB)    in use(before), in use(after), capacity(before), capacity(after),
  2764, 2765, 2888, 2888, //oldgen(KB)    in use(before), in use(after), capacity(before), capacity(after),
  0.506, 0.534, 0.512, 0.554,//timers(ms) in use, capacity, before/after
  197, 197, 0, 0,         //data          in use, capacity, before/after
]


見方がわからん。。。。
const char* space_str = stats_.space_ == kNew ? "Scavenge" : "Mark-Sweep";
OS::PrintErr(
"[ GC(%"Pd64"): %s(%s), "  // GC(isolate), space(reason)
  "%"Pd", "  // count
  "%.3f, "  // start time
  "%.3f, "  // total time
  "%"Pd", %"Pd", %"Pd", %"Pd", "  // new gen: in use, capacity before/after
  "%"Pd", %"Pd", %"Pd", %"Pd", "  // old gen: in use, capacity before/after
  "%.3f, %.3f, %.3f, %.3f, "  // times
  "%"Pd", %"Pd", %"Pd", %"Pd", "  // data
"]\n",  // End with a comma to make it easier to import in spreadsheets.


PrintStats()で出力している。
before/afterはいいとして、used/capacity

stats_.timesとdata_は何だ？

4の配列
times_[kDataEntries]
data_[kDataEntries]

RecordTime(int id, micros)
newgen id
kVisitIsolateRoots
kIterateStoreBuffers
ProcesToSpace
kIterateWeaks

oldgen id
kPageGrowth
kGarbageRatio
kGCTimeFraction
kAllowedGrowth

RecordData(int id, value)
これはStoreBufferBlockEntriesごとに、buffer->Countを設定している。

heap.h:  void RecordData(int id, intptr_t value) {
pages.cc:    heap->RecordData(PageSpace::kPageGrowth, growth_in_pages);
pages.cc:  heap->RecordData(PageSpace::kGarbageRatio, collected_garbage_ratio);
pages.cc:  heap->RecordData(PageSpace::kGCTimeFraction,
pages.cc:  heap->RecordData(PageSpace::kAllowedGrowth, grow_heap_);
scavenger.cc:  heap_->RecordData(kStoreBufferBlockEntries, buffer->Count());
scavenger.cc:  heap_->RecordData(kStoreBufferEntries, entries);

elise@elise-desktop:~/language/dart/dart-work/dart/runtime/vm$ grep RecordTime *
heap.h:  void RecordTime(int id, int64_t micros) {
pages.cc:  heap_->RecordTime(kMarkObjects, mid1 - start);
pages.cc:  heap_->RecordTime(kResetFreeLists, mid2 - mid1);
pages.cc:  heap_->RecordTime(kSweepPages, mid3 - mid2);
pages.cc:  heap_->RecordTime(kSweepLargePages, end - mid3);
scavenger.cc:  heap_->RecordTime(kVisitIsolateRoots, middle - start);
scavenger.cc:  heap_->RecordTime(kIterateStoreBuffers, end - middle);
scavenger.cc:  heap_->RecordTime(kProcessToSpace, middle - start);
scavenger.cc:  heap_->RecordTime(kIterateWeaks, end - middle);

[    GC    |  space  | count | start | gc time | new gen (KB) | old gen (KB) | timers | data ]
[ (isolate)| (reason)|       |  (s)  |   (ms)  |  used , cap  |  used , cap  |  (ms)  |      ]


