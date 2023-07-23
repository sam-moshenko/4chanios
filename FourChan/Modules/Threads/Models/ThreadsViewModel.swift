import Foundation

struct ThreadsViewModel {
    var board: Board
    var cells: [CellModel]
    
    enum Board: String, CaseIterable {
        case a, v, mu, gd, fit
        
        var description: String {
            //"/\(rawValue)/"
            switch self {
            case .a:
                return "/a/ - Anime & Manga"
            case .v:
                return "/v/ - Video Games"
            case .mu:
                return " /mu/ - Music"
            case .gd:
                return "/gd/ - Graphic Design"
            case .fit:
                return "/fit/ - Fitness"
            }
        }
    }
    
    struct CellModel {
        var id: Int
        var title: String?
        var description: String?
        var imageUrl: URL?
        var userName: String?
        var creationDate: String?
        
        init?(data: ThreadResponse.Post, board: String) {
            if data.sub == nil && data.com == nil && data.tim == nil { return nil }
            id = data.no
            title = data.sub
            description = data.cleanedDescription
            
            if let tim = data.tim, let ext = data.ext {
                imageUrl = URL(string: "https://i.4cdn.org/\(board)/\(tim)\(ext)")!
            }
            userName = data.name
            creationDate = data.formattedDate
        }
        
    }
}
