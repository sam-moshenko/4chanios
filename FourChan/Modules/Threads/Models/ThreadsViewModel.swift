import Foundation

struct ThreadsViewModel {
    var board: Board
    var cells: [CellModel]
    
    enum Board: String {
        case a, b, random
    }
    
    struct CellModel {
        var title: String
        var description: String
        var imageUrl: URL
        
        init(data: ThreadResponse.Post) {
            title = data.sub ?? "Empty"
            description = data.com ?? "Empty"
            imageUrl = URL(string: "https://is2.4chan.org/b/1687173192161749.jpg")!
        }
    }
}
