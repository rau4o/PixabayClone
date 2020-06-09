//
//  NetworkManager.swift
//  PixabayApp
//
//  Created by rau4o on 6/8/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import Moya

class NetworkManager {
    
    private let provider = MoyaProvider<WebService>()
    
    func fetchPhotos(with query: String, completion: @escaping (PhotoData, Error?) -> Void) {
        provider.request(.searchPhoto(query: query)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let photoData = try JSONDecoder().decode(PhotoData.self, from: response.data)
                    completion(photoData,nil)
                } catch (let error) {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchVideo(with query: String, completion: @escaping (VideoData, Error?) -> Void) {
        provider.request(.searchVideo(query: query)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let videoData = try JSONDecoder().decode(VideoData.self, from: response.data)
                    completion(videoData,nil)
                } catch let error {
                    print("\(error.localizedDescription) hz")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

