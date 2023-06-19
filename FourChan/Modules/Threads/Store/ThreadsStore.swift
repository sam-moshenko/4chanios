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
             chooseBoard([ThreadsViewModel.Board])
    }
    
    @Observable var state: State?
    
    private let provider: Provider = .init()
    
    func dispatch(_ action: Action) {
        switch action {
        case .viewDidLoad:
            getThreads(board: .a)
        case .boardButtonTapped:
            state = .chooseBoard(ThreadsViewModel.Board.allCases)
        case .boardDidChoose(let board):
            getThreads(board: board)
        case .didSelectThread(let cellModel):
            break
        }
    }
    
    private func getThreads(board: ThreadsViewModel.Board) {
        provider.getThreads(board.rawValue).then {
            $0.map {
                ThreadsViewModel.CellModel(data: $0.posts.first!, board: board.rawValue)
            }
        }.then {
            self.state = .initial(.init(board: board, cells: $0))
        }
    }
}
