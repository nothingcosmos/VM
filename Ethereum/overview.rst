overview
###############

ここ一読
https://y-nakajo.hatenablog.com/entry/2018/05/11/171446

http://coffeetimes.hatenadiary.jp/entry/2017/11/07/082426

dir/tree
###############

go-ethereum
https://github.com/ethereum/go-ethereum

accounts/
  abi
  keystore
  usbwallet

bmt/ Binary Merkle Tree Hash
cmd/
common/
  bitutil/
  compiler/ solidity
  fdlimit/ //os依存
  hexutil
  math
  mclock
  number

consensus/
  clique/ proof-of-authority
  ethash/
  misc
console/
containers/ docker
contracts/
  chequebook/
  ens/ naming service -> address変換
core/
  ams/
  bloombits/
  rawdb/
  state/
  types/
  vm/
  runtime/
crypto/
  bn256/ porting
    cloudflare/
    google/
  ecies/ elliptic curve
  randentropy/
  secp256k1/
  sha3/
dashboard/
eth/
  downloader/
  fetcher/
  filters/
  gasprice/
  tracers/
ethclient/
ethdb/ leveldb
ethstats/
event/
  filter/
internal/
  debug/
  ethapi/
  guide/
  jsre/
  web3ext/
les/ lightEthereum backend
light /lightChain
log/
  term/
metrics/
  exp/
  influxdb/
  librato/
miner/
mobile/
node/
p2p/
  discover/
  discv5/
  enr/
  nat/
  netutil/
  protocols/
params/
rlp/ Recursive Length Prefix
rpc/
signer/
  core/
  rules/
  storage/
swarm/
  api/
  http/
  fuse/
  metrics/
  network/
    kademlia/
  services/
     swap/
  storage/
trie/ merkle patricia tries.
vendor/
whisper/
  mailserver/
  shhclient/
  whisperv5
  whisperv6/


主要な操作はinterfaces.goから追うか
