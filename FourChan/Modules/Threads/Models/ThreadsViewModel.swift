import Foundation

struct ThreadsViewModel {
    var board: Board
    var cells: [CellModel]
    
    enum Board: String, CaseIterable {
        case a, v, mu, gd, fit
        
        var description: String {
            "/\(rawValue)/"
        }
        
        var title: String {
            switch self {
            case .a:
                return S.animeMange
            case .v:
                return S.animeMange
            case .mu:
                return S.animeMange
            case .gd:
                return S.animeMange
            case .fit:
                return S.fit
            }
        }
    }
    
    struct CellModel {
        var id: Int
        var title: String?
        var description: String?
        var imageUrl: URL?
        var author: String?
        var publishData: String?
        
        init?(data: ThreadResponse.Post, board: String) {
            if data.sub == nil && data.com == nil && data.tim == nil { return nil }
            id = data.no
            title = data.sub
            description = data.com
            if let tim = data.tim, let ext = data.ext {
                imageUrl = URL(string: "https://i.4cdn.org/\(board)/\(tim)\(ext)")!
            }
            author = data.name
            publishData = data.now
        }
    }
}
