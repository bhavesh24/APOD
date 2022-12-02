//
//  APODViewController.swift
//  APOD
//
//  Created by Bhavesh on 30/11/22.
//

import UIKit
import SafariServices

class APODViewController: UIViewController {
    
    @IBOutlet private var apodTitle: UILabel!
    @IBOutlet private var apodImageView: UIImageView!
    @IBOutlet private var apodImageLoader: UIActivityIndicatorView!
    @IBOutlet private var apodVideoButton: UIButton!
    @IBOutlet private var apodDateTextField: UITextField!
    @IBOutlet var favoritesButton: UIButton!
    @IBOutlet var apodExplanation: UILabel!
    let viewModel = APODViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        apodDateTextField.text = viewModel.getDateStringFromDate(date: Date())
        apodDateTextField.addInputViewDatePicker(target: self,
                                                 selector: #selector(updateDate),
                                                 minimumDate: viewModel.getMinimumDate(),
                                                 maximumDate: Date())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let text = apodDateTextField.text,
           !(apodDateTextField.text?.isEmpty ?? true) {
            viewModel.getAPODForDate(date: viewModel.getServerDateStringFromDisplayString(date: text))
        }
    }
    
    @objc func updateDate() {
        if let  datePicker = apodDateTextField.inputView as? UIDatePicker {
            viewModel.getAPODForDate(date: viewModel.getServerDateStringFromDate(date: datePicker.date))
        }
        apodDateTextField.resignFirstResponder()
    }
    
    func setFavoriteButton()  {
        if let apod = viewModel.currentAPOD {
            //update button image
            var image: UIImage?
            if apod.isFavorite {
                image = UIImage(systemName: "star.fill")
            } else {
                image = UIImage(systemName: "star")
            }
            favoritesButton.setImage(image, for: .normal)
        }
    }
    
    @IBAction func playVideoURL(_ sender: Any) {
        if let url = URL(string: viewModel.currentAPOD?.url ?? Constants.noSpace) {
            let config = SFSafariViewController.Configuration()
            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
    
    @IBAction func favoritesButtonAction(_ sender: Any) {
        viewModel.setAsFavorites(isFavorite: favoritesButton.image(for: .normal) == UIImage(systemName: "star"))
    }
}

extension APODViewController: APODViewModelDelegate {
    func hideShowVideoButton(isHidden: Bool) {
        apodVideoButton.isHidden = isHidden
    }
    
    func showImageLoader() {
        apodImageLoader.isHidden = false
    }
    
    func hideImageLoader() {
        apodImageLoader.isHidden = true
    }
    
    func updateImage(image: UIImage) {
        apodImageView.image = image
    }
    
    func showLoader() {
        showSpinner(onView: view)
    }
    
    func hideLoader() {
        removeSpinner()
    }
    
    func showErrorAlert(message: String) {
        DispatchQueue.main.async {
            self.hideLoader()
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                self.dismiss(animated: true)
            }))
            self.present(alert, animated: true)
        }
    }
    
    func updateAPOD() {
        apodTitle.text = viewModel.currentAPOD?.title
        apodExplanation.text = viewModel.currentAPOD?.explanation
        setFavoriteButton()
        viewModel.setImage()
        if let dateString = viewModel.currentAPOD?.date,
           let date = viewModel.getDateFromServerDateString(date: dateString) {
            apodDateTextField.text = viewModel.getDateStringFromDate(date: date)
        }
    }
}
