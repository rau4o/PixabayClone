//
//  PhotoCollectionViewCell.swift
//  PixabayApp
//
//  Created by rau4o on 6/8/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    private let photoImageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
        backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Functions
    
    private func layoutUI() {
        [photoImageView,titleLabel].forEach {
            addSubview($0)
        }
        
        photoImageView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(25)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(photoImageView.snp.bottom)
            make.left.bottom.right.equalToSuperview()
        }
    }
    
    func configureCell(photo: Hit) {
        DispatchQueue.main.async {
            self.photoImageView.kf.indicatorType = .activity
            if let photoURL = photo.previewURL {
                self.photoImageView.kf.setImage(with: URL(string: photoURL))
            }
            self.titleLabel.text = photo.tags
        }
    }
}
