import UIKit

class ThreadViewController: UITableViewController {
    private let dataSource: ThreadsTableViewDatasource = .init()
    
    init(posts: [ThreadsViewModel.CellModel]) {
        super.init(nibName: nil, bundle: nil)
        
        dataSource.items = posts
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        tableView.register(ThreadsCell.self)
        tableView.dataSource = dataSource
        tableView.delegate = self
        
        super.viewDidLoad()
    }
}


