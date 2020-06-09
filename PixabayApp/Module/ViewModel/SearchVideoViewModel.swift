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
    var videoData: [VideoHit] = []
    
    var dataSource: CollectionViewDataSourceVideo<VideoHit,VideoCollectionViewCell>?
    
    func searchVideo(with query: String, completion: @escaping() -> Void) {
        networkManager.fetchVideo(with: query) { [weak self] (video, error) in
            guard let self = self else {return}
            if let error = error {
                print(error.localizedDescription)
            }
            for i in 0..<video.hits.count {
                self.videoData.append(video.hits[i])
            }
            self.videoDidLoad(self.videoData)
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
//    func setVideo(id: Int, completion: @escaping ((URL) -> Void) ) {
//        let url = networkManager.getVideo(id: id)
//        completion(url)
////       let asset = AVAsset(url: url)
////       let playerItem = AVPlayerItem(asset: asset)
////       let player = AVPlayer(playerItem: playerItem)
////
////       let playerLayer = AVPlayerLayer(player: player)
////
////       playerLayer.videoGravity = .resizeAspect
////
////       let vc = AVPlayerViewController()
////       playerLayer.frame = vc.view.bounds
////       vc.view.layer.addSublayer(playerLayer)
////       vc.player = player
////
////       present(vc, animated: true) {
////           vc.player?.play()
////       }
//    }
    
    func deleteLoadedVideo() {
        self.videoData.removeAll()
        dataSource = .make(for: videoData, reuseIdentifier: "cellId")
    }
    
    func videoDidLoad(_ video: [VideoHit]) {
        dataSource = .make(for: video, reuseIdentifier: "cellId")
    }
    
    func numberOfElements() -> Int {
        return videoData.count
    }
    
    func getElements(at index: Int) -> VideoHit {
        return videoData[index]
    }
}
