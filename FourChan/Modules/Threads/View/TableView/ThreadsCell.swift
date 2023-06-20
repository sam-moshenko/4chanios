import UIKit
import Kingfisher

class ThreadsCell: BaseTableViewCell {
    lazy var horizontalStackView: UIStackView = build {
        $0.alignment = .top
        $0.spacing = 4
        $0.addArrangedSubview(iconImageView)
        $0.addArrangedSubview(verticalStackView)
        $0.addArrangedSubview(authorHorizontalStackView)
    }
    
    lazy var verticalStackView: UIStackView = build {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 4
        $0.addArrangedSubview(titleLabel)
        $0.addArrangedSubview(descriptionLabel)
    }
    
    lazy var authorHorizontalStackView: UIStackView = build {
        $0.axis = .vertical
        $0.spacing = 4
        $0.addArrangedSubview(auhtorLabel)
        $0.addArrangedSubview(publishDateLabel)
    }
    
    var titleLabel: UILabel = build {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    
    var descriptionLabel: UILabel = build {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        $0.numberOfLines = 2
    }
    
    var iconImageView: UIImageView = build {
        $0.contentMode = .scaleToFill
        $0.layer.cornerRadius = 4
        $0.clipsToBounds = true
        $0.snp.makeConstraints { $0.size.equalTo(60) }
    }
    
    var auhtorLabel: UILabel = build {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    
    var publishDateLabel: UILabel = build {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    
    override func setup() {
        contentView.addSubview(horizontalStackView) { $0.edges.equalToSuperview().inset(4) }
    }
    
    func configure(_ model: ThreadsViewModel.CellModel) {
        titleLabel.text = model.title
        iconImageView.isHidden = model.imageUrl == nil
        iconImageView.kf.setImage(with: model.imageUrl)
        
        if let description = model.description {
            descriptionLabel.attributedText = description.parseHTML()
        } else {
            descriptionLabel.attributedText = nil
        }
        
        if let author = model.author, let publishData = model.publishData {
            auhtorLabel.text = author
            publishDateLabel.text = publishData
        }
    }
}
