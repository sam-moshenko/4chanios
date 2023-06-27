import Foundation

struct ThreadsViewModel {
    var board: Board
    var cells: [CellModel]
    
    enum Board: String, CaseIterable { //struct
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
        //
        var author: String?
        var date: String?
        
        init?(data: ThreadResponse.Post, board: String) {
            if data.sub == nil && data.com == nil && data.tim == nil { return nil }
            id = data.no
            title = data.sub
            description = data.com
            //
            author = data.name
            date = data.now
            if let tim = data.tim, let ext = data.ext {
                imageUrl = URL(string: "https://i.4cdn.org/\(board)/\(tim)\(ext)")!
            }
        }
    }
}
