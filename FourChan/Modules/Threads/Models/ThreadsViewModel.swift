import Foundation

struct ThreadsViewModel {
    var board: Board
    var cells: [CellModel]
    
    enum Board: String, CaseIterable {
        case a, v, mu, gd, fit
        
        var description: String {
            switch self {
            case .a:
                return Common.anime
            case .v:
                return Common.videoGames
            case .mu:
                return Common.music
            case .gd:
                return Common.graphicDesign
            case .fit:
                return Common.fitness
            }
        }
    }
    
    struct CellModel {
        var id: Int
        var title: String?
        var description: String?
        var imageUrl: URL?
        var authorName: String?
        var uploadedAt: String?
        
        init?(data: ThreadResponse.Post, board: String) {
            if data.sub == nil && data.com == nil && data.tim == nil, data.now == nil, data.name == nil { return nil }
            id = data.no
            title = data.sub
            description = data.com?.convertHTMLToString()
            authorName = data.name
            uploadedAt = data.now?.convertDate()
            if let tim = data.tim, let ext = data.ext {
                imageUrl = URL(string: "https://i.4cdn.org/\(board)/\(tim)\(ext)")!
            }
        }
        
        func convertHTMLToString(_ htmlText: String?) -> String? {
            guard
                let htmlText = htmlText,
                let data = htmlText.data(using: .utf8) else {
                return nil
            }
            
            if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                return attributedString.string
            }
            
            return nil
        }
    }
}
