import UIKit
import SnapKit

final class CommentViewController: UIViewController {
    
    init(comment: ThreadsViewModel.CellModel) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var mainView: UIStackView = build {
        $0.spacing = 4
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
