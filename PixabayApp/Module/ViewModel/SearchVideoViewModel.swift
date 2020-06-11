//
//  SearchVideoViewModel.swift
//  PixabayApp
//
//  Created by rau4o on 6/9/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import Foundation

class SearchVideoViewModel {
    
    var videoData: [VideoHit] = []
    var dataSource: CollectionViewDataSourceVideo<VideoHit,VideoCollectionViewCell>?
    var dataFetcherServiceVideo = DataFetcherService()
    
    func searchVideo(query: String, completion: @escaping() -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.dataFetcherServiceVideo.fetchVideo(query: query) { [weak self] (video) in
                guard let self = self else {return}
                guard let video = video else {return}   
                let videoArr = video.hits
                for i in 0..<videoArr.count {
                    self.videoData.append(videoArr[i])
                }
                self.videoDidLoad(self.videoData)
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
    
    func deleteLoadedVideo() {
        self.videoData.removeAll()
        dataSource = .make(for: videoData, reuseIdentifier: "cellId")
    }
    
    private func videoDidLoad(_ video: [VideoHit]) {
        dataSource = .make(for: video, reuseIdentifier: "cellId")
    }
    
    func numberOfElements() -> Int {
        return videoData.count
    }
    
    func getElements(at index: Int) -> VideoHit {
        return videoData[index]
    }
}
