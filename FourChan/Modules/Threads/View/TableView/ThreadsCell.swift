import UIKit
import Kingfisher

class ThreadsCell: BaseTableViewCell {
    
    var imageUrl:URL?
    
    lazy var horizontalStackView: UIStackView = build {
        $0.alignment = .top
        $0.spacing = 4
        $0.addArrangedSubview(iconImageView)
        $0.addArrangedSubview(verticalStackView)
        $0.addArrangedSubview(postDataView)
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
    
    var descriptionLabel: UILabel = build {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        $0.numberOfLines = 7
    }
    
    var iconImageView: UIImageView = build {
        $0.layer.cornerRadius = 4
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.snp.makeConstraints { $0.size.equalTo(60) }
    }
    
    var authorLabel: UILabel = build {
        $0.font = UIFont.systemFont(ofSize: 11, weight: .thin)
    }

    var dateLabel: UILabel = build {
        $0.font = UIFont.systemFont(ofSize: 11, weight: .thin)
    }
    
    lazy var postDataView: UIStackView = build {
        $0.axis = .vertical
        $0.alignment = .trailing
        $0.addArrangedSubview(authorLabel)
        $0.addArrangedSubview(dateLabel)
    }
    


    
    override func setup() {
        contentView.addSubview(horizontalStackView) { $0.edges.equalToSuperview().inset(4) }
    }
    
    func configure(_ model: ThreadsViewModel.CellModel) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        iconImageView.isHidden = model.imageUrl == nil
        iconImageView.kf.setImage(with: model.imageUrl)
        dateLabel.text = "Today at 15:30"
        dateLabel.numberOfLines = 1
        dateLabel.adjustsFontSizeToFitWidth = true
        authorLabel.text = "Anonymous"
        imageUrl = model.imageUrl
    }
}
