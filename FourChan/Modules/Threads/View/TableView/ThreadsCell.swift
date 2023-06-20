import UIKit
import Kingfisher

class ThreadsCell: BaseTableViewCell {
    lazy var horizontalStackView: UIStackView = build {
        $0.alignment = .top
        $0.spacing = 4
        $0.addArrangedSubview(iconImageView)
        $0.addArrangedSubview(verticalStackView)
        $0.addArrangedSubview(dateLabel)
    }
    
    lazy var verticalStackView: UIStackView = build {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 4
        $0.addArrangedSubview(titleLabel)
        $0.addArrangedSubview(descriptionLabel)
    }
    
    lazy var titleAndDateStackView: UIStackView = build {
            $0.axis = .horizontal
            $0.spacing = 8
            $0.addArrangedSubview(titleLabel)
            $0.addArrangedSubview(dateLabel)
            $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    var titleLabel: UILabel = build {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.numberOfLines = 2
    }
    
    var dateLabel : UILabel = build{
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    
    var descriptionLabel: UILabel = build {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        $0.numberOfLines = 7
    }
    
    var iconImageView: UIImageView = build {
        $0.snp.makeConstraints { $0.size.equalTo(60)}
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 4
    }
    
    override func setup() {
        contentView.addSubview(horizontalStackView) { $0.edges.equalToSuperview().inset(4) }
    }
    
//    func configureDate(time: String, complition: @escaping (String) -> Void) {
//            let dateString = time
//            let originalDateFormatter = DateFormatter()
//            originalDateFormatter.dateFormat = "MM/dd/yy(EEE)HH:mm:ss"
//
//            guard let date = originalDateFormatter.date(from: dateString) else { return }
//
//            let outputDateFormatter = DateFormatter()
//            outputDateFormatter.locale = Locale(identifier: "ru_RU")
//            outputDateFormatter.dateFormat = "'Сегодня' HH:mm"
//
//            let formattedDate = outputDateFormatter.string(from: date)
//            complition(formattedDate)
//        }
    
    func configure(_ model: ThreadsViewModel.CellModel) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        iconImageView.isHidden = model.imageUrl == nil
        iconImageView.kf.setImage(with: model.imageUrl)
        dateLabel.text = model.date
        
//        guard let date = model.date else { return }
//                configureDate(time: date) { date in
//                    self.dateLabel.text = date
//        }
    }
    
    private func parseHTMLContent(_ html: String?) -> NSAttributedString? {
        guard let htmlData = html?.data(using: .utf8) else {
            return nil
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        guard let parsedHTML = try? NSMutableAttributedString(data: htmlData, options: options, documentAttributes: nil) else {
            return nil
        }
        
        // Handle line breaks
        parsedHTML.mutableString.replaceOccurrences(of: "<br>", with: "\n", options: .caseInsensitive, range: NSRange(location: 0, length: parsedHTML.length))
        
        return parsedHTML
    }
}
