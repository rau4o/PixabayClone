//
//  MainController.swift
//  PixabayApp
//
//  Created by rau4o on 6/8/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit

class MainController: UITabBarController {
        
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
    }
    
    // MARK: - Helper function
    
    private func layoutUI() {
        let searchPhotoController = UINavigationController(rootViewController: SearchPhotoController())
        let searchVideoController = UINavigationController(rootViewController: SearchVideoController())
        
        searchPhotoController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        searchVideoController.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
        
        viewControllers = [searchPhotoController, searchVideoController]
    }
}

