//
//  SearchPhotoViewModel.swift
//  PixabayApp
//
//  Created by rau4o on 6/8/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import Foundation

class SearchPhotoViewModel {
    
    var networkManager = NetworkManager()
    var photoData: [Hit] = []
    var dataSource: CollectionViewDataSource<Hit,PhotoCollectionViewCell>?
    
    func searchPhoto(with query: String, completion: @escaping() -> Void) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else {return}
            self.networkManager.fetchPhotos(with: query) { [weak self] (photo, error) in
                guard let self = self else {return}
                if let error = error {
                    print(error.localizedDescription)
                }
                let photo = photo.hits
                for i in 0..<photo.count {
                    self.photoData.append(photo[i])
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
