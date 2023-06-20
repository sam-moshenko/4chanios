import UIKit
import Kingfisher

class ThreadsCell: BaseTableViewCell {
    lazy var horizontalStackView: UIStackView = build {
        $0.alignment = .top
        $0.spacing = 4
        $0.addArrangedSubview(iconImageView)
        $0.addArrangedSubview(verticalStackView)
        $0.addArrangedSubview(postInfoStackView)
    }
    
    lazy var verticalStackView: UIStackView = build {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 4
        $0.addArrangedSubview(titleLabel)
        $0.addArrangedSubview(descriptionLabel)
    }
    
    var titleLabel: UILabel = build {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.numberOfLines = 2
    }
    
    lazy var postInfoStackView: UIStackView = build {
        $0.axis = .vertical
        $0.alignment = .trailing
        $0.spacing = 4
        $0.addArrangedSubview(ownerLabel)
        $0.addArrangedSubview(postDateLabel)
    }
    
    var ownerLabel: UILabel = build {
        $0.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        $0.numberOfLines = 0
    }
    
    var postDateLabel: UILabel = build {
        $0.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        $0.numberOfLines = 0
    }
    
    var descriptionLabel: UILabel = build {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        $0.numberOfLines = 7
    }
    
    var iconImageView: UIImageView = build {
        $0.snp.makeConstraints { $0.size.equalTo(60) }
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    override func setup() {
        contentView.addSubview(horizontalStackView) { $0.edges.equalToSuperview().inset(4) }
    }
    
    func configure(_ model: ThreadsViewModel.CellModel) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        iconImageView.isHidden = model.imageUrl == nil
        ownerLabel.text = model.postOwner
        postDateLabel.text = model.postDate
        iconImageView.kf.setImage(with: model.imageUrl)
    }
}
