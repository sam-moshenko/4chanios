import UIKit
import Kingfisher

class ThreadsCell: BaseTableViewCell {
    
    var iconDidTapped: ((ThreadResponse.Post) -> Void)?
    
    lazy var horizontalStackView: UIStackView = build {
        $0.alignment = .top
        $0.spacing = 4
        $0.addArrangedSubview(iconImageView)
        $0.addArrangedSubview(verticalStackView)
        $0.addArrangedSubview(nameAndDateStackView)
    }
    
    lazy var verticalStackView: UIStackView = build {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 4
        $0.addArrangedSubview(titleLabel)
        $0.addArrangedSubview(descriptionLabel)
    }
    lazy var nameAndDateStackView: UIStackView = build {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 4
        $0.addArrangedSubview(date)
        $0.addArrangedSubview(name)
    }
    
    var titleLabel: UILabel = build {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.numberOfLines = 2
    }
    
    var descriptionLabel: UILabel = build {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        $0.numberOfLines = 7
    }
    
    lazy var iconImageView: UIImageView = build {
        $0.layer.cornerRadius = 4
        $0.snp.makeConstraints { $0.size.equalTo(60) }
    }
    var date: UILabel = build {
        $0.font = UIFont.systemFont(ofSize: 10, weight: .regular)
    }
    var name: UILabel = build {
        $0.font = UIFont.systemFont(ofSize: 10, weight: .regular)
    }
    var model: ThreadResponse.Post?
    
    override func setup() {
        contentView.addSubview(horizontalStackView) { $0.edges.equalToSuperview().inset(4) }
    }
    override func setAction() {
        self.iconImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
        self.isUserInteractionEnabled = true
    }
    @objc func imageTapped() {
        guard let model = model else {return}
        iconDidTapped?(model)
        print("icon was tapped \(model.name)")
    }
    func configure(_ model: ThreadsViewModel.CellModel) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        iconImageView.isHidden = model.imageUrl == nil
        iconImageView.kf.setImage(with: model.imageUrl)
        guard let time = model.time else { return }
        configureDate(time: time) { time in
            self.date.text = time
        }
        name.text = model.name
    }
    func configureDate(time: String, complition: @escaping (String) -> Void) {
        let dateString = time
        let originalDateFormatter = DateFormatter()
        originalDateFormatter.dateFormat = "MM/dd/yy(EEE)HH:mm:ss"
        
        guard let date = originalDateFormatter.date(from: dateString) else { return }
        
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.locale = Locale(identifier: "ru_RU")
        outputDateFormatter.dateFormat = "'Сегодня' HH:mm"
        
        let formattedDate = outputDateFormatter.string(from: date)
        complition(formattedDate)
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
        
        parsedHTML.mutableString.replaceOccurrences(of: "<br>", with: "\n", options: .caseInsensitive, range: NSRange(location: 0, length: parsedHTML.length))
        
        return parsedHTML
    }
}
