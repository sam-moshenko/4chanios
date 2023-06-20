import UIKit

class ThreadsTableViewDatasource: NSObject, UITableViewDataSource, UITableViewDelegate {
    var items: [ThreadsViewModel.CellModel] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell: ThreadsCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(item)
        cell.iconDidTapped = { [weak self] model in
//            self?.handleIconDidTapped(model: model)
//            this func in ThreadsViewController
        }
        cell.setAction()
        return cell
    }
}
