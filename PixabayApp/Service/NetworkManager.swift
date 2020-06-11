//
//  NetworkManager.swift
//  PixabayApp
//
//  Created by rau4o on 6/8/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import Moya

protocol NetworkManagerDelegate {
    func fetchGenericJSONData<T: Decodable>(target: WebService, response: @escaping (T) -> Void)
}

class NetworkManager: NetworkManagerDelegate {
    
    private let provider = MoyaProvider<WebService>()
    
    func fetchGenericJSONData<T>(target: WebService, response: @escaping (T) -> Void) where T : Decodable {
        provider.request(target) { (result) in
            switch result {
            case .success(let callResponse):
                guard let decode = self.decodeJSON(type: T.self, from: callResponse.data) else {return}
                response(decode)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func decodeJSON<T: Decodable>(type: T.Type, from: Data) -> T? {
        do {
            let decoderJson = JSONDecoder()
            let jsonData = try decoderJson.decode(type.self, from: from)
            return jsonData
        } catch let error {
            print("\(error.localizedDescription)hz")
            return nil
        }
    }
}

