import UIKit
import SnapKit

class ThreadsViewController: UIViewController {
    lazy var contentView: ThreadsView = build {
        $0.delegate = self
    }
    private let store: ThreadsStore = .init()
    
    override func viewDidLoad() {
        //При переходе в темный режим виден белый фон, исправить чтобы в темном режиме фон становился черным
        view.backgroundColor = .systemBackground
        view.addSubview(contentView) { $0.edges.equalTo(view.safeAreaLayoutGuide) }
        super.viewDidLoad()
        subscribe()
        store.dispatch(.viewDidLoad)
        
    }
    
    func showBoards(_ boards: [ThreadsViewModel.Board]) {
        //Добавить локализацию
        let alertController = UIAlertController(title: "Выберите доску", message: nil, preferredStyle: .alert)
        boards.forEach { board in
            let action = UIAlertAction(title: board.description, style: .default) { _ in
                self.store.dispatch(.boardDidChoose(board))
            }
            alertController.addAction(action)
        }
        // Добавить кнопку отмены в выборе досок
        let buttonCancel = UIAlertAction(title: "Отмена", style: .cancel)
        alertController.addAction(buttonCancel)
        present(alertController, animated: true)
    }
    
    private func subscribe() {
        store.$state.observe(self) { vc, state in
            switch state {
            case .none:
                break
            case .initial(let viewModel):
                vc.contentView.configure(viewModel)
            case .chooseBoard(let boards):
                vc.showBoards(boards)
            case .openThread(let cellModels):
                let threadVc = ThreadViewController(posts: cellModels)
                vc.present(threadVc, animated: true)
            }
        }
    }
}

extension ThreadsViewController: ThreadsViewDelegate {
    func boardButtonTapped() {
        store.dispatch(.boardButtonTapped)
    }
    
    func didSelectItem(_ item: ThreadsViewModel.CellModel) {
        store.dispatch(.didSelectThread(item))
    }
}


