//
//  WebService.swift
//  PixabayApp
//
//  Created by rau4o on 6/8/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import Moya

private let key = "16945692-e5a73f51e07ae9b1c9b4e4312"

enum WebService {
    case searchPhoto(query: String)
    case searchVideo(query: String)
}

extension WebService: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://pixabay.com/api/") else { fatalError("OPS") }
        return url
    }
    
    var path: String {
        switch self {
        case .searchPhoto:
            return ""
        case .searchVideo:
            return "videos/"
        }
    }
    
    var method: Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
            case .searchPhoto(let query):
                return .requestParameters(parameters: ["key": key, "q": query], encoding: URLEncoding.default)
            case .searchVideo(let query):
                return .requestParameters(parameters: ["key": key, "q": query], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
