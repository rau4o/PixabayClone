//
//  PhotoData.swift
//  PixabayApp
//
//  Created by rau4o on 6/8/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import Foundation

struct PhotoData: Decodable {
    let hits: [Hit]
}

struct Hit: Decodable {
    let type, tags: String?
    let previewURL: String?
    let largeImageURL, fullHDURL, imageURL: String?
}
