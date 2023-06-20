import UIKit
import Kingfisher

protocol ThreadsCellDelegate: AnyObject {
    func threadsCellDidTapImage(_ cell: ThreadsCell, imageUrl: URL)
}

class ThreadsCell: BaseTableViewCell {
    
    var model: ThreadsViewModel.CellModel?
    weak var delegate: ThreadsCellDelegate?
    
    lazy var horizontalStackView: UIStackView = build {
        $0.alignment = .top
        $0.spacing = 4
        $0.addArrangedSubview(iconImageView)
        $0.addArrangedSubview(contentVerticalStackView)
    }
    
    lazy var contentVerticalStackView: UIStackView = build {
        $0.axis = .vertical
        $0.spacing = 4
        $0.addArrangedSubview(titleStackView)
        $0.addArrangedSubview(descriptionLabel)
    }
    
    lazy var titleStackView: UIStackView = build {
        $0.axis = .horizontal
        $0.addArrangedSubview(titleLabel)
        $0.addArrangedSubview(UIView())
        $0.addArrangedSubview(verticalStackView)
    }
    
    lazy var verticalStackView: UIStackView = build {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 4
        $0.addArrangedSubview(nameLabel)
        $0.addArrangedSubview(dateLabel)
    }
    
    var titleLabel: UILabel = build {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.numberOfLines = 2
    }
    
    var descriptionLabel: UILabel = build {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        $0.numberOfLines = 2
    }
    
    var iconImageView: UIImageView = build {
        $0.snp.makeConstraints {
            $0.size.equalTo(60)
        }
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    
    var nameLabel: UILabel = build {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        $0.numberOfLines = 2
    }
    
    var dateLabel: UILabel = build {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        $0.numberOfLines = 2
    }
    
    override func setup() {
        contentView.addSubview(horizontalStackView) { $0.edges.equalToSuperview() }
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        verticalStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
        }
        
        // Add a tap gesture recognizer to the iconImageView
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(iconImageViewTapped))
        iconImageView.isUserInteractionEnabled = true
        iconImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func iconImageViewTapped() {
         guard let model = model, let imageUrl = model.imageUrl else { return }
         delegate?.threadsCellDidTapImage(self, imageUrl: imageUrl)
     }
    
    
    func configure(_ model: ThreadsViewModel.CellModel) {
        self.model = model
        titleLabel.text = model.title ?? "Title"
        descriptionLabel.text = model.parsedDescription
        iconImageView.isHidden = model.imageUrl == nil
        iconImageView.kf.setImage(with: model.imageUrl)
        nameLabel.text = model.name
        dateLabel.text = model.parsedDate ?? "No date"
    }
}
