import UIKit
import SnapKit

class ThreadsViewController: UIViewController {
    lazy var contentView: ThreadsView = build {
        $0.delegate = self
    }
    private let store: ThreadsStore = .init()
    
    var indicator: UIActivityIndicatorView = build {
        $0.startAnimating()
    }
    
    lazy var loadView: UIViewController = build{
        $0.modalPresentationStyle = .overFullScreen
        $0.view.backgroundColor = .gray.withAlphaComponent(0.5)
        $0.view.addSubview(indicator)
        indicator.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
    }
    
    let localizedString = NSLocalizedString("helloKey", comment: "")
    
    func showLoad() {
        guard loadView.isBeingPresented == false else { return }
        present(self.loadView, animated: false)
    }
    
    
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
        let alertController = UIAlertController(title: NSLocalizedString("boardkey", comment: ""), message: nil, preferredStyle: .alert)
        boards.forEach { board in
            let action = UIAlertAction(title: board.id, style: .default) { _ in
                self.store.dispatch(.boardDidChoose(board))
                self.showLoad()
            }
            alertController.addAction(action)
        }
        // Добавить кнопку отмены в выборе досок
        let buttonCancel = UIAlertAction(title: NSLocalizedString("cancelkey", comment: ""), style: .cancel)
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
            case .loading:
                vc.showLoad()
            case .loadingFinish:
                self.loadView.hideload()
            }
        }
    }
}

extension ThreadsViewController: ThreadsViewDelegate, ThreadsCellDelegate {
    func boardButtonTapped() {
        store.dispatch(.boardButtonTapped)
    }
    
    func imageTapped() {
        store.dispatch(.imageTapped)
    }
    
    func didSelectItem(_ item: ThreadsViewModel.CellModel) {
        store.dispatch(.didSelectThread(item))
    }
}

extension UIViewController {
    func hideload () {
        guard self.isBeingDismissed == false  else { return }
        dismiss(animated: false)
    }
}
