import Promises

extension Provider {
    func getThreads(_ board: String) -> Promise<[ThreadResponse]> {
        request("\(board)/threads.json").then { (response: [ThreadsResponse]) in
            let threadsPromises: [Promise<ThreadResponse>] = response[0].threads.map {
                self.request("\(board)/thread/\($0.no).json")
            }
            return Promises.all(threadsPromises)
        }
    }
}
