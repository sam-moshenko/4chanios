


import UIKit
import Kingfisher

class ImageViewController: UIViewController {
    
    var imageUrl: URL?
    var imageView: UIImageView = build {
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        loadImage()
    }
    
    private func loadImage() {
        guard let imageUrl = imageUrl else {
            return
        }
        
        imageView.kf.setImage(with: imageUrl)
    }
}
