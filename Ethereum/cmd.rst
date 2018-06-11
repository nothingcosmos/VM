cmd
###########################

cmdから主制御部分を把握できるようにする

まずはgethから


var
  app = utils.NewApp()

init
  appの初期化
  Action = geth //main entry point
  

main
  app.Run()
  //geth
    node := makeFullNode(ctx)
    startNode(ctx, node)
      StartNode(node)
      ethereum.StartMining()
    node.Wait()



rpc
###################

jsonRPC

method, jsonrpc, id,params



