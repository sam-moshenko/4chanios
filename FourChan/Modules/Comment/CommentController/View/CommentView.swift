import UIKit
import SnapKit

class CommentView: BaseView {
    
    lazy var verticalStackView: UIStackView = build {
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 10
        $0.addArrangedSubview(iconImageView)
    }
    
    private lazy var iconImageView: UIImageView = build {
        $0.snp.makeConstraints {
            $0.size.equalTo(60)
        }
    }
    
    override func setup() {
        addSubview(verticalStackView) { $0.edges.equalToSuperview().inset(8) }
    }
    
    func configure(_ model: ThreadsViewModel.CellModel) {
        iconImageView.isHidden = model.imageUrl == nil
        iconImageView.kf.setImage(with: model.imageUrl)
    }
}
