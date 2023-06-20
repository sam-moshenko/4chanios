import Foundation

extension String {
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }
    
    func convertDate() -> String? {
        
        let originalDateFormat = "MM/dd/yy(EEE)HH:mm:ss"
        let targetDateFormat = "EEEE HH:mm"
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        
        dateFormatter.dateFormat = originalDateFormat
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = targetDateFormat
            return dateFormatter.string(from: date)
        }
        
        return nil
    }
    
    func convertHTMLToString() -> String? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            return attributedString.string
        }
        
        return nil
    }
}
