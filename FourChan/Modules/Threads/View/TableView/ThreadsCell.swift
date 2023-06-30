import UIKit
import Kingfisher

class ThreadsCell: BaseTableViewCell {
    
    lazy var horizontalStackView: UIStackView = build {
        $0.axis = .horizontal
        $0.alignment = .top
        $0.spacing = 4
        $0.addArrangedSubview(iconImageView)
        $0.addArrangedSubview(verticalStackView)
    }
    
    lazy var verticalStackView: UIStackView = build {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 4
        $0.addArrangedSubview(horizontalStackViewHead)
        $0.addArrangedSubview(horizontalStackViewDescription)
    }
    
    lazy var horizontalStackViewDescription: UIStackView = build {
        $0.axis = .horizontal
        $0.alignment = .top
        $0.spacing = 4
        $0.addArrangedSubview(descriptionLabel)
    }

    
    lazy var horizontalStackViewHead: UIStackView = build {
        $0.axis = .horizontal
        $0.alignment = .top
        $0.spacing = 4
        $0.addArrangedSubview(verticalStackViewTitle)
        $0.addArrangedSubview(verticalStackViewAuthorAndDate)

    }
        
    lazy var verticalStackViewTitle: UIStackView = build {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 4
        $0.addArrangedSubview(titleLabel)
    }
    
    lazy var verticalStackViewAuthorAndDate: UIStackView = build {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.addArrangedSubview(authorLabel)
        $0.addArrangedSubview(dateLabel)
    }
    
    var titleLabel: UILabel = build {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.numberOfLines = 2
    }
    
    var descriptionLabel: UILabel = build {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        $0.numberOfLines = 7
    }
    
    var iconImageView: UIImageView = build {
        $0.snp.makeConstraints { $0.size.equalTo(60) }
        $0.contentMode = .scaleToFill
        $0.layer.cornerRadius = 4
        $0.clipsToBounds = true
    }
    
    var authorLabel: UILabel = build {
        $0.font = UIFont.systemFont(ofSize: 9, weight: .bold)
        $0.numberOfLines = 1
    }
    var dateLabel: UILabel = build {
        $0.font = UIFont.systemFont(ofSize: 9, weight: .bold)
        $0.numberOfLines = 2
    }
    
    override func setup() {
        contentView.addSubview(horizontalStackView) { $0.edges.equalToSuperview().inset(4) }
    }
    
    func configure(_ model: ThreadsViewModel.CellModel) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        authorLabel.text = model.author
        dateLabel.text = model.date
        iconImageView.isHidden = model.imageUrl == nil
        iconImageView.kf.setImage(with: model.imageUrl)
    }
}
