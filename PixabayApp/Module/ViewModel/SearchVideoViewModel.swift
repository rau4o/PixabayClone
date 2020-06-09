//
//  SearchVideoViewModel.swift
//  PixabayApp
//
//  Created by rau4o on 6/9/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import Foundation
import HCVimeoVideoExtractor

class SearchVideoViewModel {
    var networkManager = NetworkManager()
    var videoData: [Videos] = []
    
    var dataSource: CollectionViewDataSourceVideo<Videos,VideoCollectionViewCell>?
    
    func searchVideo(with query: String, completion: @escaping() -> Void) {
        networkManager.fetchVideo(with: query) { [weak self] (video, error) in
            guard let self = self else {return}
            if let error = error {
                print(error.localizedDescription)
            }
            for i in 0..<video.hits.count {
                self.videoData.append(video.hits[i].videos)
            }
            self.videoDidLoad(self.videoData)
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    func deleteLoadedVideo() {
        self.videoData.removeAll()
        dataSource = .make(for: videoData, reuseIdentifier: "cellId")
    }
    
    func videoDidLoad(_ video: [Videos]) {
        dataSource = .make(for: video, reuseIdentifier: "cellId")
    }
    
    func numberOfElements() -> Int {
        return videoData.count
    }
    
    func getElements(at index: Int) -> Videos {
        return videoData[index]
    }
}
