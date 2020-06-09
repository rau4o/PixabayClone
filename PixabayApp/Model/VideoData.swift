//
//  VideoData.swift
//  PixabayApp
//
//  Created by rau4o on 6/9/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import Foundation

struct VideoData: Decodable {
    let hits: [VideoHit]
}

struct VideoHit: Decodable {
    let tags: String?
    let videos: Videos
}

struct Videos: Decodable {
    let large, medium, small, tiny: Large
}

struct Large: Decodable {
    let url: String?
}

struct CurrentVideo {
    var tags: String?
    var url: String?
    
    init?(videoData: VideoData) {
        for i in 0..<videoData.hits.count {
            tags = videoData.hits[i].tags
            url = videoData.hits[i].videos.medium.url
        }
    }
}
