//
//  DataRequest+Promise.swift
//  Kcell-Activ
//
//  Created by Nurlan Tolegenov on 4/22/20.
//  Copyright © 2020 Azimut Labs. All rights reserved.
//

import Alamofire
import Foundation
import Promises

private enum Constants {
    static let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
}

extension DataRequest {
    @discardableResult
    func toPromise<Response: Decodable>() -> Promise<Response> {
        wrap { completionHandler in
            self.responseDecodable(decoder: Constants.jsonDecoder, completionHandler: completionHandler)
        }.then { dataResponse -> Response in
            try dataResponse.result.get()
        }
    }
    
    func toVoidPromise() -> Promise<Void> {
        return Promise { fullfill, reject in
            self.validate(statusCode: 200...299).response { response in
                switch response.result {
                case .success:
                    fullfill(Void())
                case .failure(let error):
                    reject(error)
                }
            }
        }
    }
}
