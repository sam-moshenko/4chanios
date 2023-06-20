import UIKit
import SnapKit

class ThreadsViewController: UIViewController {
    lazy var contentView: ThreadsView = build {
        $0.delegate = self
    }
    private let store: ThreadsStore = .init()
    
    override func viewDidLoad() {
        view.addSubview(contentView) { $0.edges.equalTo(view.safeAreaLayoutGuide) }
        super.viewDidLoad()
        
        subscribe()
        store.dispatch(.viewDidLoad)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            updateBackgroundColor()
        }
    }
    
    private func updateBackgroundColor() {
        let isDarkMode = traitCollection.userInterfaceStyle == .dark
        view.backgroundColor = isDarkMode ? .black : .white
    }
    
    func showBoards(_ boards: [ThreadsViewModel.Board]) {
        let alertController = UIAlertController(title: NSLocalizedString("CHOOSE", comment: "choose board"), message: nil, preferredStyle: .alert)
        boards.forEach { board in
            let action = UIAlertAction(title: board.description, style: .default) { _ in
                self.store.dispatch(.boardDidChoose(board))
            }
            alertController.addAction(action)
        }
        let cancelAction = UIAlertAction(title: NSLocalizedString("CANCEL", comment: "cancel board"), style: .cancel, handler: nil)
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
