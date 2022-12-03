//
//  DetailsViewModel.swift
//  APOD
//
//  Created by Bhavesh on 03/12/22.
//

import Foundation
import UIKit

class DetailsViewModel {
    
    var apod: APOD?
    var apodImage: UIImage?
    
    func getDateFromServerDateString(date: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.yyyyMMdd.rawValue
        return dateFormatter.date(from: date)
    }
    
    func getDisplayStringFromServerDateString() -> String {
        let apodDate = apod?.date ?? Constants.noSpace
        let date = getDateFromServerDateString(date: apodDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        if let date = date {
            return dateFormatter.string(from: date)
        } else {
            return Constants.noSpace
        }
    }
}
