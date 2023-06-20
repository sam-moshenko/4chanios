import UIKit
import Kingfisher

class ThreadsCell: BaseTableViewCell {
    lazy var horizontalStackView: UIStackView = build {
        $0.alignment = .top
        $0.spacing = 4
        $0.addArrangedSubview(iconImageView)
        $0.addArrangedSubview(verticalStackView)
    }
    
    lazy var verticalStackView: UIStackView = build {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 4
        $0.addArrangedSubview(titleHorizontalStackView)
        $0.addArrangedSubview(descriptionLabel)
    }
    
    lazy var titleHorizontalStackView: UIStackView = build {
        $0.alignment = .top
        $0.spacing = 12
        $0.addArrangedSubview(titleLabel)
        $0.addArrangedSubview(authorVerticalStackView)
    }
    
    lazy var authorVerticalStackView: UIStackView = build {
        $0.axis = .vertical
        $0.alignment = .trailing
        $0.spacing = 4
        $0.addArrangedSubview(authorNameLabel)
        $0.addArrangedSubview(dateLabel)
    }
    
    var titleLabel: UILabel = build {
        $0.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width/2)
        }
        $0.numberOfLines = 2
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    
    var authorNameLabel: UILabel = build {
        $0.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width/4)
        }
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        $0.numberOfLines = 0
    }
    
    var dateLabel: UILabel = build {
        $0.numberOfLines = 0
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        $0.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width/4)
        }
    }
    
    var descriptionLabel: UILabel = build {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        $0.numberOfLines = 7
    }
    
    var iconImageView: UIImageView = build {
        $0.contentMode = .scaleToFill
        $0.layer.cornerRadius = 4
        $0.snp.makeConstraints { $0.size.equalTo(60) }
    }
    
    override func setup() {
        contentView.addSubview(horizontalStackView) { $0.edges.equalToSuperview().inset(4) }
    }
    
    func configure(_ model: ThreadsViewModel.CellModel) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        authorNameLabel.text = model.authorName
        dateLabel.text = model.uploadedAt
        iconImageView.isHidden = model.imageUrl == nil
        iconImageView.kf.setImage(with: model.imageUrl)
    }
}
