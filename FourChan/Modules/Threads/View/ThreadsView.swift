import UIKit
import SnapKit

protocol ThreadsViewDelegate: AnyObject {
    func boardButtonTapped()
    func didSelectItem(_ item: ThreadsViewModel.CellModel)
}

class ThreadsView: BaseView {
    lazy var stackView: UIStackView = build {
        $0.axis = .vertical
        $0.spacing = 8
        $0.addArrangedSubview(boardButton)
        $0.addArrangedSubview(tableView)
    }
    
    lazy var boardButton: UIButton = build(.init(type: .roundedRect)) {
        $0.addTarget(self, action: #selector(boardButtonTapped), for: .touchUpInside)
    }
    
    lazy var tableView: UITableView = build {
        $0.register(ThreadsCell.self)
        $0.dataSource = dataSource
        $0.delegate = self
    }
    
    weak var delegate: ThreadsViewDelegate?
    
    private let dataSource: ThreadsTableViewDatasource = .init()
    
    override func setup() {
        addSubview(stackView) { $0.edges.equalToSuperview().inset(8) }
    }
    
    func configure(_ viewModel: ThreadsViewModel) {
        dataSource.items = viewModel.cells
        tableView.reloadData()
        boardButton.setTitle(viewModel.board.description, for: .normal)
    }
    
    @objc
    func boardButtonTapped() {
        delegate?.boardButtonTapped()
    }
    
    
}

extension ThreadsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectItem(dataSource.items[indexPath.row])
    }
}
