import UIKit
import SnapKit

protocol ThreadsViewDelegate: AnyObject {
    func boardButtonTapped()
    func cancelButtonTapped()
    func didSelectItem(_ item: ThreadsViewModel.CellModel)
   
}

class ThreadsView: BaseView, UITableViewDelegate {
    
    lazy var stackView: UIStackView = build {
        $0.axis = .vertical
        $0.spacing = 8
        $0.addArrangedSubview(boardButtonStackView)
        $0.addArrangedSubview(tableView)
    }
    
    lazy var boardButtonStackView: UIStackView = build {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.addArrangedSubview(boardButton)
        $0.addArrangedSubview(cancelButton)
    }
    
    lazy var boardButton: UIButton = build(.init(type: .roundedRect)) {
        $0.addTarget(self, action: #selector(boardButtonTapped), for: .touchUpInside)
        $0.titleLabel?.numberOfLines = 2
        $0.titleLabel?.lineBreakMode = .byTruncatingTail
    }
    
    lazy var cancelButton: UIButton = build(.init(type: .roundedRect)) {
        $0.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        $0.setTitle(NSLocalizedString("Cancel", comment: ""), for: .normal)
        
    }
    
    lazy var tableView: UITableView = build {
        $0.register(ThreadsCell.self)
        $0.dataSource = dataSource
        $0.delegate = self
    }
    
    weak var delegate: ThreadsViewDelegate?
    private let dataSource: ThreadsTableViewDatasource = .init()
    private var isChoosingBoard: Bool = false
    
    override func setup() {
        addSubview(stackView) { $0.edges.equalToSuperview().inset(8) }
    }
    
    func configure(_ viewModel: ThreadsViewModel) {
        dataSource.items = viewModel.cells
        tableView.reloadData()
        
        if isChoosingBoard {
            boardButtonStackView.isHidden = true
        } else {
            boardButtonStackView.isHidden = false
            boardButton.setTitle(viewModel.board?.description, for: .normal)
        }
    }
    
    @objc func boardButtonTapped() {
        isChoosingBoard = true
        boardButtonStackView.isHidden = true
        delegate?.boardButtonTapped()
    }
    
    @objc func cancelButtonTapped() {
        isChoosingBoard = false
        boardButtonStackView.isHidden = false
        delegate?.cancelButtonTapped()
    }
    
    
}
