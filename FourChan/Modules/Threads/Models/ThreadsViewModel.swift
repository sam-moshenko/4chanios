import Foundation

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
                return "Graphic design"
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
        
        init?(data: ThreadResponse.Post, board: String) {
            if data.sub == nil && data.com == nil && data.tim == nil { return nil }
            id = data.no
            title = data.sub
            description = data.com
            if let tim = data.tim, let ext = data.ext {
                imageUrl = URL(string: "https://i.4cdn.org/\(board)/\(tim)\(ext)")!
                
            }
        }
    }
}
