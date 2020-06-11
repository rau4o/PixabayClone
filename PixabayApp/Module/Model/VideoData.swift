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
    let videos: Videos?
    let id: Int?
    let pageURL: String?
    let picture_id: String?
}

struct Videos: Decodable {
    let large, medium, small, tiny: Large
}

struct Large: Decodable {
    let url: String?
}
