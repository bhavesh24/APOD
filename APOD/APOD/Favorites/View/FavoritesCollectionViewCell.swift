//
//  FavoritesCollectionViewCell.swift
//  APOD
//
//  Created by Bhavesh on 02/12/22.
//

import UIKit

protocol FavoritesCollectionViewCellDelegate: AnyObject {
    func removeFavorites(tag: Int)
}

class FavoritesCollectionViewCell: UICollectionViewCell {
    @IBOutlet var favoritesImageView: UIImageView!
    @IBOutlet var favoritesTitleLabel: UILabel!
    
    weak var delegate: FavoritesCollectionViewCellDelegate?
    
    @IBAction func removeFavorites(_ sender: Any) {
        delegate?.removeFavorites(tag: tag)
    }
}
