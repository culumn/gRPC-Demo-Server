import Foundation
import gRPC

let latch = CountDownLatch(1)
let provider: Proto_UserServiceProvider = Provider()
let server = Proto_UserServiceServer(address: "localhost:50051", provider: provider)
server.start()
latch.wait()
