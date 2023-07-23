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
//        let tapGesture = UITapGestureRecognizer (target: self, action: #selector(imgTap(tapGesture:)))
//        tapGesture.numberOfTapsRequired = 1
//        cell.iconImageView.isUserInteractionEnabled = true
//        cell.iconImageView.addGestureRecognizer(tapGesture)
        

        return cell
    }
    
    @objc
    func imgTap(tapGesture: UITapGestureRecognizer) {
       //Do further execution where you need idToMove
        let imgView = tapGesture.view as! UIImageView
        let idToMove = imgView.tag
    }
}
