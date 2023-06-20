import UIKit
import SnapKit

class ThreadsViewController: UIViewController {
    lazy var contentView: ThreadsView = build {
        $0.delegate = self
    }
    private let store: ThreadsStore = .init()
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        view.addSubview(contentView) { $0.edges.equalTo(view.safeAreaLayoutGuide) }
        super.viewDidLoad()
        
        subscribe()
        store.dispatch(.viewDidLoad)
    }
    
    func showBoards(_ boards: [ThreadsViewModel.Board]) {
        let alertController = UIAlertController(title: Common.chooseBoard, message: nil, preferredStyle: .alert)
        boards.forEach { board in
            let action = UIAlertAction(title: board.description, style: .default) { _ in
                self.store.dispatch(.boardDidChoose(board))
            }
            alertController.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: Common.cancel, style: .cancel)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
    private func subscribe() {
        store.$state.observe(self) { vc, state in
            switch state {
            case .none:
                break
            case .initial(let viewModel):
                vc.contentView.configure(viewModel)
                self.hideLoader()
            case .chooseBoard(let boards):
                vc.showBoards(boards)
            case .openThread(let cellModels):
                let threadVc = ThreadViewController(posts: cellModels)
                self.hideLoader()
                vc.present(threadVc, animated: true)
            case .openComment(let cellModel):
                let commentVc = CommentViewController(comment: cellModel)
                vc.present(commentVc, animated: true)
            }
        }
    }
    
    public func showLoader() {
        let vc = LoaderViewController()
        present(vc, animated: true)
    }
    
    public func hideLoader() {
        dismiss(animated: true)
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
