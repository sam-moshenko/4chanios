import Foundation
import Promises
import Alamofire

class ThreadsStore {
    enum Action {
        case viewDidLoad,
             boardButtonTapped,
             imageTapped,
             boardDidChoose(ThreadsViewModel.Board),
             didSelectThread(ThreadsViewModel.CellModel)
        
    }
    
    enum State {
        case initial(ThreadsViewModel),
             chooseBoard([ThreadsViewModel.Board]),
             openThread([ThreadsViewModel.CellModel]),
             loading,
             loadingFinish
            
        
    }
    
    @Observable var state: State?
    
    private var cached: [Int: [ThreadsViewModel.CellModel]] = [:]
    private var boards: [ThreadsViewModel.Board] = []
    private let provider: Provider = .init()
    
    func dispatch(_ action: Action) {
        switch action {
        case .viewDidLoad:
            getThreadsAndBoards()
        case .boardButtonTapped:
            state = .chooseBoard(boards)
        case .boardDidChoose(let board):
            getThreads(board: board)
        case .didSelectThread(let cellModel):
            state = .openThread(cached[cellModel.id]!)
        case .imageTapped:
            state = .loading
        }
    }
    
    private func getThreads(board: ThreadsViewModel.Board) -> Promise<Void> {
        state = .loading
        return provider.getThreads(board.id).then {
            $0.compactMap {
                let cellModels = $0.posts.compactMap {
                    ThreadsViewModel.CellModel(data: $0, board: board.id)
                }
                guard let first = cellModels.first else { return nil }
                self.cached[first.id] = cellModels
                return first
            }
        }.then {
            self.state = .initial(.init(board: board, cells: $0))
        }.always {
            self.state = .loadingFinish
        }
    }
    
    private func getThreadsAndBoards() -> Promise<Void> {
        state = .loading
        return provider.getBoards().then {
            self.boards = $0.boards.map(ThreadsViewModel.Board.init)
            return self.getThreads(board: self.boards.first!)
        }.always {
            self.state = .loadingFinish
        }
    }
    
    
}




