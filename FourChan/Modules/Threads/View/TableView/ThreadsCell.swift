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
        
        $0.addArrangedSubview(titleStackView)
        $0.addArrangedSubview(descriptionLabel)
    }
    
    lazy var titleStackView: UIStackView = build {
        $0.spacing = 2
        $0.axis = .horizontal
        
        $0.addArrangedSubview(titleLabel)
        $0.addArrangedSubview(metaStackView)
    }
    
    lazy var metaStackView: UIStackView = build {
        $0.axis = .vertical
        $0.alignment = .trailing
        $0.spacing = 2
        
        $0.addArrangedSubview(userName)
        $0.addArrangedSubview(creationDate)
    }
    
    var titleLabel: UILabel = build {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.numberOfLines = 2
        
        $0.frame = CGRect(x: 150, y: 150, width: 200, height: 20)
    }
    var userName: UILabel = build {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
    }
    var creationDate: UILabel = build {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
    }
    
    var descriptionLabel: UILabel = build {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        $0.numberOfLines = 7
    }
    
    var iconImageView: UIImageView = build {
        $0.layer.cornerRadius = 4
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
        $0.snp.makeConstraints {
            $0.size.equalTo(60)
        }
        
    }
    
    override func setup() {
        contentView.addSubview(horizontalStackView) { $0.edges.equalToSuperview().inset(4) }
    }
    
    func configure(_ model: ThreadsViewModel.CellModel) {
        titleLabel.text = model.title
        userName.text = model.userName
        creationDate.text = model.creationDate
        descriptionLabel.text = model.description
        iconImageView.isHidden = model.imageUrl == nil
        iconImageView.kf.setImage(with: model.imageUrl)
    }
}


