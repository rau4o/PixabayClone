//
//  DetailPhotoController.swift
//  PixabayApp
//
//  Created by rau4o on 6/10/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit

class DetailPhotoController: UIViewController {
    
    let mainImageView: UIImageView = {
        let image = UIImageView()
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        view.backgroundColor = .white
    }
    
    private func layoutUI() {
        view.addSubview(mainImageView)
        mainImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
