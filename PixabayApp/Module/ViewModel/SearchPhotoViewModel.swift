//
//  SearchPhotoViewModel.swift
//  PixabayApp
//
//  Created by rau4o on 6/8/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import Foundation

class SearchPhotoViewModel {
    
    var photoData: [Hit] = []
    var dataSource: CollectionViewDataSource<Hit,PhotoCollectionViewCell>?
    var dataFetcherService = DataFetcherService()
    
    func fetchJSONPhoto(query: String, completion: @escaping() -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.dataFetcherService.fetchPhoto(query: query) { [weak self] (photo) in
                guard let photo = photo else { return }
                guard let self = self else {return}
                let photoArr = photo.hits
                for i in 0..<photoArr.count {
                    self.photoData.append(photoArr[i])
                }
                self.photoDidLoad(self.photoData)
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
    
    func deleteLoadedPhoto() {
        self.photoData.removeAll()
        dataSource = .make(for: photoData, reuseIdentifier: "cellId")
    }
    
    private func photoDidLoad(_ photo: [Hit]) {
        dataSource = .make(for: photo, reuseIdentifier: "cellId")
    }
    
    func numberOfElements() -> Int {
        return photoData.count
    }
    
    func getElements(at index: Int) -> Hit {
        return photoData[index]
    }
}
