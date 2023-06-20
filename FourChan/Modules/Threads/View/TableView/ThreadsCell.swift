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
        $0.snp.makeConstraints {
            make in
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        $0.layer.cornerRadius = 4
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
    }
    
    override func setup() {
        contentView.addSubview(horizontalStackView) { $0.edges.equalToSuperview().inset(4) }
    }
    
    func configure(_ model: ThreadsViewModel.CellModel) {
        if let title = model.title, let formattedDate = model.formattedCreationDate(), let username = model.username {
            let combinedString = "\(title) - \(formattedDate) - \(username)"
            let attributedString = NSMutableAttributedString(string: combinedString)
            
            let titleRange = (combinedString as NSString).range(of: title)
            let titleAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 16, weight: .bold)
            ]
            attributedString.addAttributes(titleAttributes, range: titleRange)
            
            let usernameRange = (combinedString as NSString).range(of: username)
            let usernameAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 12, weight: .regular)
            ]
            attributedString.addAttributes(usernameAttributes, range: usernameRange)
            let formattedDateRange = (combinedString as NSString).range(of: formattedDate)
            let formattedDateAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 12, weight: .regular),
                .foregroundColor: UIColor.gray // Adjust the color as desired
            ]
            attributedString.addAttributes(formattedDateAttributes, range: formattedDateRange)
            
            titleLabel.attributedText = attributedString
            
            
        } else {
            titleLabel.text = model.title
        }
        descriptionLabel.text = model.description
        iconImageView.isHidden = model.imageUrl == nil
        iconImageView.kf.setImage(with: model.imageUrl)
        
        if model.username != nil && model.formattedCreationDate() != nil {
            horizontalStackView.axis = .horizontal
        } else {
            horizontalStackView.axis = .vertical
        }
    }
}
