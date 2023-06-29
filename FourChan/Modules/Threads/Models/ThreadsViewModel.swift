import Foundation

struct ThreadsViewModel {
    var board: Board
    var cells: [CellModel]
    
    enum Board: String, CaseIterable { 
        //Добавить новую доску, например /fit/
        case a, v, mu, gd, fit
        
        
        var description: String {
            "/\(rawValue)/"
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
        var dateChange = date
        if date.contains("(") {
            dateChange.insert(" ", at: dateChange.firstIndex(of: "(")! )
            dateChange.removeSubrange(dateChange.firstIndex(of: "(")!...dateChange.firstIndex(of: ")")!)
        }
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MM/dd/yy HH:mm:ss"
        dateFormater.timeZone = TimeZone(secondsFromGMT: 0)
        let dateReturn = dateFormater.date(from: dateChange)
        return dateReturn!
    }
    
    func dayConfigure(date: Date) -> String {
        let currentDate = Date()
        let calendar = Calendar.current
        var timeComponents = calendar.dateComponents([.day, .month, .hour, .minute, .second], from: date)
        timeComponents.timeZone = .current
        let day = timeComponents.day ?? 0
        let month = timeComponents.month ?? 0
        let hour = timeComponents.hour ?? 0
        let minute = timeComponents.minute ?? 0
        
        if calendar.dateComponents([.year, .month, .day], from: date) == calendar.dateComponents([.year, .month, .day], from: currentDate) {
            return("Сегодня \(hour):\(minute)")
        } else {
            return("\(day).\(month) \(hour):\(minute)")
        }
    }
    
    func dateConfigure (date: String) -> String {
        let date = dateTransform(date: date)
        let dateBoard = dayConfigure(date: date)
        return dateBoard
    }
}
