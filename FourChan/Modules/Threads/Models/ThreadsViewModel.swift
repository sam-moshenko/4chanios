import Foundation

struct ThreadsViewModel {
    var board: Board?
    var cells: [CellModel]
    var isChoosingBoard: Bool = false
    
    enum Board: String, CaseIterable {
        case a, v, mu, gd, fit
        
        var description: String {
            let boardURLString = "https://boards.4channel.org/\(rawValue)/"
            guard let boardURL = URL(string: boardURLString) else {
                return "/\(rawValue)/"
            }
            
            let semaphore = DispatchSemaphore(value: 0)
            var description: String = "/\(rawValue)/"
            
            URLSession.shared.dataTask(with: boardURL) { (data, response, error) in
                defer { semaphore.signal() }
                
                if let error = error {
                    print("Error retrieving board description: \(error)")
                    return
                }
                
                guard let data = data else {
                    print("No data received for board description")
                    return
                }
                
                if let html = String(data: data, encoding: .utf8),
                   let startRange = html.range(of: "<title>"),
                   let endRange = html.range(of: "</title>") {
                    let titleRange = startRange.upperBound..<endRange.lowerBound
                    let title = html[titleRange].replacingOccurrences(of: " - 4chan", with: "")
                    description = "/\(self.rawValue)/ - \(title)"
                }
            }.resume()
            
            _ = semaphore.wait(timeout: .distantFuture)
            
            return description
        }
    }
    
    
    struct CellModel {
        var id: Int
        var title: String?
        var description: String?
        var imageUrl: URL?
        var creationDate: Date?
        var username: String?
        
        init?(data: ThreadResponse.Post, board: String) {
            if data.sub == nil && data.com == nil && data.tim == nil { return nil }
            id = data.no
            title = data.sub
            description = data.com
            if let tim = data.tim, let ext = data.ext {
                imageUrl = URL(string: "https://i.4cdn.org/\(board)/\(tim)\(ext)")!
            }
            // Set the creation date and username properties
//            if let timestamp = data.time {
//                creationDate = Date(timeIntervalSince1970: TimeInterval(timestamp))
//            }
//            username = data.username // Update this line to use the correct property name for username
        }
    
        //
        func formattedCreationDate() -> String? {
            guard let creationDate = creationDate else {
                return nil
            }
            // Format the creation date as desired
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .short
            return dateFormatter.string(from: creationDate)
        }
    }
}
