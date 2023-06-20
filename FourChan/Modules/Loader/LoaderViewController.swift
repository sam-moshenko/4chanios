import UIKit

class LoaderViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoaderView()
    }
    
    private func setupLoaderView() {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        
        view.addSubview(activityIndicator)
    }
}
