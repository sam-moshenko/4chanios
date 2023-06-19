import UIKit
import SnapKit

class ThreadsViewController: UIViewController {
    let contentView: ThreadsView = .init()
    private let store: ThreadsStore = .init()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(contentView) { $0.edges.equalTo(view.safeAreaLayoutGuide) }
        super.viewDidLoad()
        
        subscribe()
        store.dispatch(.viewDidLoad)
    }
    
    private func subscribe() {
        store.$state.observe(self) { vc, state in
            switch state {
            case .none:
                break
            case .initial(let viewModel):
                vc.contentView.configure(viewModel)
            }
        }
    }
}
