//
//  ShowImageViewController.swift
//  FourChan
//
//  Created by Manarbek Bibit on 20.06.2023.
//

import UIKit
import SnapKit

class ShowImageViewController: UIViewController {
    let iconImage: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    var model: ThreadResponse.Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(iconImage)
        iconImage.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
    }
}
