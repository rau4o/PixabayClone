//
//  CollectionViewDataSource.swift
//  PixabayApp
//
//  Created by rau4o on 6/8/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit

extension UICollectionView {
    func dequeueCell<Cell: UICollectionViewCell>(withIdentifier identifier: String, for indexPath: IndexPath) -> Cell{
        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! Cell
    }
}

final class CollectionViewDataSource<Model, Cell: UICollectionViewCell>: NSObject, UICollectionViewDataSource {
    
    typealias CellConfigurator = (Model,Cell) -> Void
    
    var models: [Model]
    
    private let reuseIdentifier: String
    private let cellConfigurator: CellConfigurator
    
    init(models: [Model], reuseIdentifier: String, cellConfigurator: @escaping CellConfigurator) {
        self.models = models
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = cellConfigurator
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = models[indexPath.item]
        let cell: Cell = collectionView.dequeueCell(withIdentifier: reuseIdentifier, for: indexPath)
        cellConfigurator(model,cell)
        return cell
    }
}

extension CollectionViewDataSource where Model == Hit {
    static func make(for photo: [Hit], reuseIdentifier: String) -> CollectionViewDataSource {
        return CollectionViewDataSource(models: photo, reuseIdentifier: reuseIdentifier) { (photo, cell) in
            if let cell = cell as? PhotoCollectionViewCell {
                cell.configureCell(photo: photo)
            }
        }
    }
}
