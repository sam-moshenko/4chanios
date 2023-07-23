import Foundation

struct ThreadsResponse: Decodable {
    let page: Int
    let threads: [Thread]
    
    struct Thread: Decodable {
        let no: Int
    }
}

struct ThreadResponse: Decodable {
    let posts: [Post]
    
    struct Post: Decodable {
        let no: Int
        let sub: String?
        let com: String?
        let tim: Int?
        let ext: String?
        let name: String?
        let time: Double
        
        var formattedDate: String  {
            let currentDate = Date()
            let postDate = Date(timeIntervalSince1970: time)
            let formatter = RelativeDateTimeFormatter()
            formatter.unitsStyle = .full
            formatter.dateTimeStyle = .named
            return formatter.localizedString(for: postDate, relativeTo: currentDate)
        }
        
        var cleanedDescription: String {
            return com?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil) ?? ""
        }
    }
}
