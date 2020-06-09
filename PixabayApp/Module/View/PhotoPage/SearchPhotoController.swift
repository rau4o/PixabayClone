//
//  SearchPhotoController.swift
//  PixabayApp
//
//  Created by rau4o on 6/8/20.
//  Copyright © 2020 rau4o. All rights reserved.
//

import UIKit
import SnapKit

private let cellId = "cellId"
private let heightCell: CGFloat = 200

class SearchPhotoController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel = SearchPhotoViewModel()
    let detailController = DetailPhotoController()
    private let searchController = UISearchController(searchResultsController: nil)
    dynamic var changedSizeCell: CGFloat = 1
    
    var segmentedControl: UISegmentedControl = {
        let items = ["1x1", "2x2", "3x3"]
        let customSC = UISegmentedControl(items: items)
        customSC.selectedSegmentIndex = 0
        customSC.superview?.clipsToBounds = true
        customSC.superview?.layer.borderWidth = 1
        customSC.backgroundColor = .white
        customSC.addTarget(self, action: #selector(handleSegmentControl(_:)), for: .valueChanged)
        return customSC
    }()
    
    let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    
    lazy private var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        return collectionView
    }()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    // MARK: - Selectors
    
    @objc func handleSegmentControl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            changedSizeCell = 1
            collectionView.reloadData()
        }

        if sender.selectedSegmentIndex == 1 {
            changedSizeCell = 2
            collectionView.reloadData()
        }

        if sender.selectedSegmentIndex == 2 {
            changedSizeCell = 3
            collectionView.reloadData()
        }
    }
}

// MARK: - LayoutUI

extension SearchPhotoController {
    
    func initialSetup() {
        view.backgroundColor = .white
        layoutUI()
        setupNavigationBar()
        setupSearchController()
    }
    
    private func layoutUI() {
        [segmentedControl,collectionView].forEach {
            view.addSubview($0)
        }
        
        segmentedControl.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(30)
            make.bottom.equalTo(collectionView.snp.top)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.right.left.bottom.equalToSuperview()
            make.top.equalTo(segmentedControl.snp.bottom)
        }
    }
    
    private func setupNavigationBar(){
        navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Search Photo"
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

extension SearchPhotoController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.tintColor = .black
        guard let query = searchBar.text else {return}
        viewModel.searchPhoto(with: query) { [weak self] in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.collectionView.dataSource = self.viewModel.dataSource
                self.collectionView.reloadData()
            }
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.deleteLoadedPhoto()
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension SearchPhotoController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width / changedSizeCell ) - 16
        let heigth = (view.frame.width / changedSizeCell ) - 30
        return CGSize(width: width, height: heigth)
    }
}

// MARK: - UICollectionViewDelegate

extension SearchPhotoController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentPhoto = viewModel.getElements(at: indexPath.item).imageURL
        guard let currentImage = currentPhoto else { return }
        navigationController?.pushViewController(detailController, animated: true)
        detailController.mainImageView.kf.setImage(with: URL(string: currentImage))
    }
}
