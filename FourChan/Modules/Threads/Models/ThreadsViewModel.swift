import UIKit


struct ThreadsViewModel {
    var board: Board
    var cells: [CellModel]
    
    
    enum Board: String, CaseIterable {
        case a, v, mu, gd, fit
        
        var description: String {
            switch self {
            case .a:
                return "Anime & Manga"
            case .v:
                return "Video Games"
            case .mu:
                return "Music"
            case .gd:
                return "Graphic Design"
            case .fit:
                return "Fitness"
            }
        }
    }
    
    struct CellModel {
        var id: Int
        var title: String?
        var description: String?
        var imageUrl: URL?
        var name: String?
        var now: String?
  
        var parsedDate: String? {
            let relativeDateFormatter = DateFormatter()
            relativeDateFormatter.timeStyle = .none
            relativeDateFormatter.dateStyle = .medium
            relativeDateFormatter.locale = Locale(identifier: "ru_RU")
            relativeDateFormatter.doesRelativeDateFormatting = true
            
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            timeFormatter.locale = Locale(identifier: "ru_RU")
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yy(EEE)HH:mm:ss"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            
            if let date = dateFormatter.date(from: now ?? "") {
                let relativeDateString = relativeDateFormatter.string(from: date)
                let timeString = timeFormatter.string(from: date)
                return "\(relativeDateString) \(timeString)"
            }
            
            return nil
        }
        
        var parsedDescription: String? {
            let newDesc = description ?? ""
            guard let data = newDesc.data(using: .utf8) else {
                return nil
            }
            
            guard let attributedString = try? NSAttributedString(data: data,
                                                                  options: [.documentType: NSAttributedString.DocumentType.html],
                                                                  documentAttributes: nil) else {
                return nil
            }
            
            let parsedString = attributedString.string
            return parsedString
        }

        
        init?(data: ThreadResponse.Post, board: String) {
            if data.sub == nil && data.com == nil && data.tim == nil { return nil }
            id = data.no
            title = data.sub
            description = data.com
            name = data.name
            now = data.now
            if let tim = data.tim, let ext = data.ext {
                imageUrl = URL(string: "https://i.4cdn.org/\(board)/\(tim)\(ext)")
            }
        }
    }



}

