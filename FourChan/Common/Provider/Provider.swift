import Foundation
import Alamofire
import Promises

class Provider {
    enum Constants {
        static let baseUrl = "https://a.4cdn.org/"
    }
    
    func request<T: Decodable>(_ partialPath: String) -> Promise<T> {
        AF.request("\(Constants.baseUrl)\(partialPath)").toPromise().catch {
            print($0)
        }
    }
}
