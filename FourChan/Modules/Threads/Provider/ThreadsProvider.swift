import Promises

extension Provider {
    func getThreads(_ board: String) -> Promise<[ThreadResponse]> {
        request("\(board)/threads.json").then { (response: [ThreadsResponse]) in
            let threadsPromises: [Promise<ThreadResponse>] = response[0].threads.map {
                self.getThreadContent(board: board, thread: $0.no)
            }
            return Promises.all(threadsPromises)
        }
    }
    
    func getThreadContent(board: String, thread: Int) -> Promise<ThreadResponse> {
        request("\(board)/thread/\(thread).json")
    }
    
    func getBoards() -> Promise<ThreadResponse> {
        request("boards.json")
    }
}
