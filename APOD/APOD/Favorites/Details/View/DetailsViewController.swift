//
//  DetailsViewController.swift
//  APOD
//
//  Created by Bhavesh on 03/12/22.
//

import UIKit
import SafariServices

class DetailsViewController: UIViewController {
    
    enum DetailsConstants {
        static let title = "Details"
    }
    
    @IBOutlet var apodImageView: UIImageView!
    @IBOutlet var apodTitleLabel: UILabel!
    @IBOutlet var apodDateLabel: UILabel!
    @IBOutlet var apodExplanationLabel: UILabel!
    @IBOutlet var apodVideoButton: UIButton!
    
    var viewModel: DetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = DetailsConstants.title
        apodTitleLabel.text = viewModel?.apod?.title
        apodDateLabel.text = viewModel?.getDisplayStringFromServerDateString()
        apodImageView.image = viewModel?.apodImage
        apodExplanationLabel.text = viewModel?.apod?.explanation
        apodVideoButton.isHidden = viewModel?.apod?.APODMediaTypeEnum != .video
    }

    @IBAction func playVideoURL(_ sender: Any) {
        if let url = URL(string: viewModel?.apod?.url ?? Constants.noSpace) {
            let config = SFSafariViewController.Configuration()
            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
}
