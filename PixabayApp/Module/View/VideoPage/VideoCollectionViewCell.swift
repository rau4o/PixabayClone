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
        [photoImageView, titleLabel].forEach {
            addSubview($0)
        }
        
        photoImageView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(30)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(photoImageView.snp.bottom)
            make.left.bottom.right.equalToSuperview()
        }
    }
    
    func configureCell(video: VideoHit) {
        DispatchQueue.main.async {
            self.photoImageView.kf.indicatorType = .activity
            self.photoImageView.kf.setImage(with: URL(string: "https://i.vimeocdn.com/video/\(video.picture_id)_\("640x360").jpg"))
            self.titleLabel.text = video.tags
        }
    }
}
