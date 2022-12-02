//
//  APODViewModel.swift
//  APOD
//
//  Created by Bhavesh on 01/12/22.
//

import Foundation
import UIKit

protocol APODViewModelDelegate: AnyObject {
    func updateAPOD()
    func showLoader()
    func hideLoader()
    func showErrorAlert(message: String)
    func updateImage(image: UIImage)
    func showImageLoader()
    func hideImageLoader()
    func hideShowVideoButton(isHidden: Bool)
}

enum ErrorMessage {
    static let unknownError = "Unknown error"
}

class APODViewModel {
    weak var delegate: APODViewModelDelegate?
    var currentAPOD: APOD? {
        didSet {
            self.delegate?.updateAPOD()
        }
    }
    
    func getMinimumDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.yyyyMMdd.rawValue
        let minimumDate = dateFormatter.date(from: "1995-06-16")
        
        return minimumDate
    }
    
    func getDateStringFromDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
    
    func getServerDateStringFromDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.yyyyMMdd.rawValue
        return dateFormatter.string(from: date)
    }
    
    func getDateFromServerDateString(date: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.yyyyMMdd.rawValue
        return dateFormatter.date(from: date)
    }
    
    func getAPODForDate(date: String) {
        if let currentAPOD = CoreDataManager.sharedManager.fetchSavedAPODFor(date: date) {
            self.currentAPOD = currentAPOD
        } else {
            fetchAPODFromServer(date: date)
        }
    }
    
    func fetchAPODFromServer(date: String) {
        delegate?.showLoader()
        NetworkClient.shared().getData(completionBlock: { [weak self] result in
            guard let strongSelf = self else { return }
            strongSelf.delegate?.hideLoader()
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let decoder = JSONDecoder()
                    decoder.userInfo[CodingUserInfoKey.managedObjectContext] = CoreDataManager.sharedManager.persistentContainer.viewContext
                    strongSelf.currentAPOD = try? decoder.decode(APOD.self, from: data)
                    CoreDataManager.sharedManager.saveContext()
                }
            case .failure(let error):
                let networkError = error as? NetworkError
                switch networkError {
                case .invalidURL:
                    strongSelf.delegate?.showErrorAlert(message: networkError?.description ?? Constants.noSpace)
                case .invalidResponse(_, _):
                    strongSelf.delegate?.showErrorAlert(message: networkError?.description ?? Constants.noSpace)
                case .none:
                    if  ((try? Reachability().connection == .unavailable) ?? false) {
                        strongSelf.delegate?.showErrorAlert(message: Reachability.Connection.unavailable.description)
                    }
                    strongSelf.delegate?.showErrorAlert(message: ErrorMessage.unknownError)
                }
            }
        }, queryParams: [QueryParams.thumbs: "true",
                         QueryParams.date: date])
    }
    
    func loadImageURL(url: String) {
        guard let url = URL(string: url)else {
            return
        }
        delegate?.hideShowVideoButton(isHidden: true)
        if let image = UIImage(named: "load-icon-png-7952") {
            self.delegate?.updateImage(image: image)
        }
        delegate?.showImageLoader()
        NetworkClient.shared().loadImageData(url: url) { [weak self] data, error in
            DispatchQueue.main.async {
                guard let strongSelf = self, let data = data, let image = UIImage(data: data) else {
                    return
                }
                strongSelf.delegate?.hideImageLoader()
                strongSelf.delegate?.updateImage(image: image)
                // should show play button
                strongSelf.delegate?.hideShowVideoButton(isHidden: strongSelf.currentAPOD?.APODMediaTypeEnum != .video)
            }
        }
    }
    
    func setImage() {
        if let imageURL = currentAPOD?.imageURL {
            loadImageURL(url: imageURL)
        }
    }
    
    func setAsFavorites(isFavorite: Bool) {
        currentAPOD?.isFavorite = isFavorite
        CoreDataManager.sharedManager.saveContext()
        (delegate as? APODViewController)?.setFavoriteButton()
    }
}
