NUMA関連のオプション
###############################################################################

UseNUMA
UseNUMAInterleaving
NUMAInterleaveGranularity 2M

オプションはruntime/globals

NUMA系は、
gc/shareのTLAB関連にはNUMAのオプション関係あり。
もしくはParallelGCに影響ある。
G1GCには直接関係ない。

UseTLAB thread-local object allocation
===============================================================================

allocate
memory/threadLocalAllocBuffer::allocate
invariants() あまり関係ない

jdk 1.7 を見た感じ XX:useNUMAというのは要するに、
あるスレッドからしか使われないメモリとグローバルヒープを分ける。
ローカルヒープからグローバルヒープに遷移するときに mbind(INTERELEAVE) するという戦略のようだ。


LinuxのAUTONUMAとのアンマッチ
===============================================================================
大きなヒープをNUMA無視して扱っていると関係なくなる。

numaで確保したメモリがlarge pageにfitするように調整するのみ。
numa向けにadaptiveなpage sizeの調整。region

linux/os_linux.cpp
id = os::numa_get_group_id()
thread->set_lgrp_id(id)

UseNUMAInterleaving
  numa_make_global(addr,size)

Linux::numa_interleave_memory
Linux::numa_tonode_memory

gc
bias_region()
  os::numa_make_local()
    numa_tonode_memory()


MutableNUMASpace
parallelScavengeのeden_spaceのみ

GCから呼ばれるNUMA関連のsystem call
===============================================================================

static void set_sched_getcpu(sched_getcpu_func_t func) { _sched_getcpu = func; }
static void set_numa_node_to_cpus(numa_node_to_cpus_func_t func) { _numa_node_to_cpus = func; }
static void set_numa_max_node(numa_max_node_func_t func) { _numa_max_node = func; }
static void set_numa_available(numa_available_func_t func) { _numa_available = func; }
static void set_numa_tonode_memory(numa_tonode_memory_func_t func) { _numa_tonode_memory = func; }
static void set_numa_interleave_memory(numa_interleave_memory_func_t func) { _numa_interleave_memory = f
static void set_numa_all_nodes(unsigned long* ptr) { _numa_all_nodes = ptr; }
static int sched_getcpu_syscall(void);


