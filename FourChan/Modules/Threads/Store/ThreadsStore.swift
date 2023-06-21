import Foundation
import Promises
import Alamofire

class ThreadsStore {
    enum Action {
        case viewDidLoad,
             boardButtonTapped,
             boardDidChoose(ThreadsViewModel.Board),
             didSelectThread(ThreadsViewModel.CellModel),
             boardCancelButtonTapped
    }
    
    enum State {
        case initial(ThreadsViewModel),
             chooseBoard([ThreadsViewModel.Board]),
             openThread([ThreadsViewModel.CellModel])
    }
    
    @Observable var state: State?
    
    private var cached: [Int: [ThreadsViewModel.CellModel]] = [:]
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
            state = .openThread(cached[cellModel.id]!)
        case .boardCancelButtonTapped:
            print("dismissed")
        }
    }
    
    private func getThreads(board: ThreadsViewModel.Board) {
//        state = .loading
        provider.getThreads(board.rawValue).then {
            $0.compactMap {
                let cellModels = $0.posts.compactMap {
                    ThreadsViewModel.CellModel(data: $0, board: board.rawValue)
                }
                guard let first = cellModels.first else { return nil }
                self.cached[first.id] = cellModels
                return first
            }
        }.then {
            self.state = .initial(.init(board: board, cells: $0))
        }
    }
}
