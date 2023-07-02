import Foundation

struct ThreadsViewModel {
    var board: Board
    var cells: [CellModel]
    
    struct Board {
        var id: String
        var title: String
        
        var description: String {
            "/\(id)/ - \(title)"
        }
        
        init(data: Boards.Board){
            id = data.board
            title = data.title
        }
    }
    

    
    struct CellModel {
        var id: Int
        var title: String?
        var description: String?
        var imageUrl: URL?
        var author: String?
        var date: String?
        

        
        init?(data: ThreadResponse.Post, board: String) {
            if data.sub == nil && data.com == nil && data.tim == nil && data.now == nil { return nil }
            id = data.no
            title = data.sub
            description = data.com
            author = data.name
            if let now = data.now {
                date = dateConfigure(date: now)
            }
            if let tim = data.tim, let ext = data.ext {
                imageUrl = URL(string: "https://i.4cdn.org/\(board)/\(tim)\(ext)")!
            }
        }
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        return try? NSAttributedString(data: data, options: options, documentAttributes: nil)
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? self
    }
}

extension ThreadsViewModel.CellModel {
    func dateTransform(date: String) -> Date {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MM/dd/yy(EEE)HH:mm:ss"
        dateFormater.timeZone = .current
        dateFormater.locale = Locale(identifier: "en_US_POSIX")
        let dateReturn = dateFormater.date(from: date)
        return dateReturn!
    }
    
    func dayConfigure(date: Date) -> String {
        let currentDate = Date()
        let timeFormatter = RelativeDateTimeFormatter()
        timeFormatter.locale = Locale(identifier: "ru-RU")
        timeFormatter.dateTimeStyle = .numeric
        timeFormatter.unitsStyle = .spellOut
        return timeFormatter.localizedString(for: date, relativeTo: currentDate)
        
    }
    
    func dateConfigure (date: String) -> String {
        let date = dateTransform(date: date)
        let dateBoard = dayConfigure(date: date)
        return dateBoard
    }
    

}
