//
//  FavoritesViewController.swift
//  APOD
//
//  Created by Bhavesh on 02/12/22.
//

import UIKit

class FavoritesViewController: UIViewController {

    enum Constants {
        static let cellIdentifier = "favoritesCellIdentifier"
    }
    
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet var emptyFavoritesLabel: UILabel!
    let viewModel = FavoritesViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        collectionView.dataSource = self
        viewModel.fetchFavorites()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchFavorites()
    }
}

extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.APODFavorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as! FavoritesCollectionViewCell
        cell.delegate = self
        let apod = viewModel.APODFavorites[indexPath.row]
        cell.favoritesTitleLabel.text = apod.title
        if let url = apod.imageURL {
            viewModel.loadImageURL(url: url, imageView: cell.favoritesImageView)
        }
        cell.tag = indexPath.row
        
        return cell
    }
}

extension FavoritesViewController: FavoritesCollectionViewCellDelegate {
    func removeFavorites(tag: Int) {
        viewModel.removeFavorites(index: tag)
    }
}

extension FavoritesViewController: FavoritesViewModelDelegate {
    func reloadData() {
        collectionView.reloadData()
        emptyFavoritesLabel.isHidden = !viewModel.APODFavorites.isEmpty
    }
}
