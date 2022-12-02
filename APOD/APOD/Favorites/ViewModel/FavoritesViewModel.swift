//
//  FavoritesViewModel.swift
//  APOD
//
//  Created by Bhavesh on 02/12/22.
//

import Foundation
import UIKit

protocol FavoritesViewModelDelegate: AnyObject {
    func reloadData()
}

class FavoritesViewModel {
    var APODFavorites:[APOD] = []
    weak var delegate: FavoritesViewModelDelegate?
    
    func fetchFavorites() {
        APODFavorites = CoreDataManager.sharedManager.fetchAPODFavorites() ?? []
        delegate?.reloadData()
    }
    
    func removeFavorites(index: Int) {
        APODFavorites[index].isFavorite = false
        CoreDataManager.sharedManager.saveContext()
        fetchFavorites()
    }
    
    func loadImageURL(url: String, imageView: UIImageView) {
        guard let url = URL(string: url)else {
            imageView.image = UIImage(named: "load-icon-png-7952")
            return
        }
        
        NetworkClient.shared().loadImageData(url: url) { data, error in
            DispatchQueue.main.async {
                guard let data = data, let image = UIImage(data: data) else {
                    imageView.image = UIImage(named: "load-icon-png-7952")
                    return
                }
                imageView.image = image
                return
            }
        }
    }
}
