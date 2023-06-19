import Foundation
import Promises
import Alamofire

class ThreadsStore {
    enum Action {
        case viewDidLoad,
             boardButtonTapped,
             didSelectThread(ThreadsViewModel.CellModel)
    }
    
    enum State {
        case initial(ThreadsViewModel)
    }
    
    @Observable var state: State?
    
    private var board: ThreadsViewModel.Board = .a
    private let provider: Provider = .init()
    
    func dispatch(_ action: Action) {
        switch action {
        case .viewDidLoad:
            getThreads()
        case .boardButtonTapped:
            getThreads()
        case .didSelectThread(let cellModel):
            break
        }
    }
    
    private func getThreads() {
        provider.getThreads(board.rawValue).then {
            $0.map {
                ThreadsViewModel.CellModel(data: $0.posts.first!)
            }
        }.then {
            self.state = .initial(.init(board: self.board, cells: $0))
        }
    }
}
