import Foundation
import Promises
import Alamofire

class ThreadsStore {
    enum Action {
        case viewDidLoad,
             boardButtonTapped,
             boardDidChoose(ThreadsViewModel.Board),
             didSelectThread(ThreadsViewModel.CellModel)
        
    }
    
    enum State {
        case initial(ThreadsViewModel),
             chooseBoard([ThreadsViewModel.Board]),
             openThread([ThreadsViewModel.CellModel])
        
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
        }
    }
    
    private func getThreads(board: ThreadsViewModel.Board) {
        //loading
        provider.getThreads(board.id).then {
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
            //loadingfinished
        }
    }
    
    private func getThreadsAndBoards () {
        //loading
        provider.getBoards().then {
            self.boards = $0.boards.map(ThreadsViewModel.Board.init)
            self.getThreads(board: self.boards.first!)
        }.always {
            //loadingfinish
        }
        
    }
    
}




