//
//  SearchVideoController.swift
//  PixabayApp
//
//  Created by rau4o on 6/8/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

private let cellId = "cellId"

protocol TranferVideoDelegate: class {
    func transferVideo(url: String)
}

class SearchVideoController: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: TranferVideoDelegate?
    var viewModel = SearchVideoViewModel()
    private let searchController = UISearchController(searchResultsController: nil)
    
    let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    
    lazy private var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        initialSetup()
    }
}

// MARK: - LayoutUI

extension SearchVideoController {
    
    func initialSetup() {
        view.backgroundColor = .white
        layoutUI()
        setupNavigationBar()
        setupSearchController()
    }
    
    private func layoutUI() {
        [collectionView].forEach {
            view.addSubview($0)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupNavigationBar(){
        navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Search"
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.backgroundColor = .white
    }
    
    private func setupSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.delegate = self
    }
}

// MARK: - UISearchBarDelegate

extension SearchVideoController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.tintColor = .black
        guard let query = searchBar.text else {return}
        viewModel.searchVideo(with: query) { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.collectionView.dataSource = self.viewModel.dataSource
                self.collectionView.reloadData()
            }
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.deleteLoadedVideo()
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension SearchVideoController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width / 2 ) - 16
        let heigth = (view.frame.width / 2 ) - 30
        return CGSize(width: width, height: heigth)
    }
}

// MARK: - UICollectionViewDelegate

extension SearchVideoController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentVideo = viewModel.getElements(at: indexPath.item).small.url
        if let currentVideo = currentVideo {
            WebController.shared.urlString = currentVideo
            self.navigationController?.pushViewController(WebController.shared, animated: true)
        }
    }
}