import UIKit

class ThreadsTableViewDatasource: NSObject, UITableViewDataSource, UITableViewDelegate, ThreadsCellDelegate {
    weak var viewController: UIViewController?
    
    func threadsCellDidTapImage(_ cell: ThreadsCell, imageUrl: URL) {
        print("qwe")
        let imageViewController = ImageViewController(imageUrl: imageUrl)
        let navController = UINavigationController(rootViewController: imageViewController)
        navController.modalPresentationStyle = .formSheet // Set the desired presentation style
        
        if let viewController = viewController {
            viewController.present(navController, animated: true, completion: nil)
        } else {
            print("View controller is not set")
        }
    }
    
    var items: [ThreadsViewModel.CellModel] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell: ThreadsCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(item)
        cell.delegate = self
        return cell
    }
}
