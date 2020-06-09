//
//  VideoCollectionViewCell.swift
//  PixabayApp
//
//  Created by rau4o on 6/9/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit

class VideoCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
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
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Functions
    
    private func layoutUI() {
        addSubview(photoImageView)
        
        photoImageView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(30)
        }
    }
    
    func configureCell(video: VideoHit) {
        photoImageView.kf.setImage(with: URL(string: "https://i.vimeocdn.com/video/\(video.picture_id)_\("640x360").jpg"))
    }
}
