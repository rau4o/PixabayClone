//
//  DataFetcherService.swift
//  PixabayApp
//
//  Created by rau4o on 6/10/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import Foundation

class DataFetcherService {
    var networkDataFetcher: NetworkManagerDelegate

    init(networkDataFetcher: NetworkManagerDelegate = NetworkManager()) {
        self.networkDataFetcher = networkDataFetcher
    }
    
    func fetchPhoto(query: String, completion: @escaping (PhotoData?) -> Void) {
        networkDataFetcher.fetchGenericJSONData(target: .searchPhoto(query: query), response: completion)
    }

    func fetchVideo(query: String, completion: @escaping (VideoData?) -> Void) {
        networkDataFetcher.fetchGenericJSONData(target: .searchVideo(query: query), response: completion)
    }
}
