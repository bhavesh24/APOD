//
//  APOD+CoreDataProperties.swift
//  APOD
//
//  Created by Bhavesh on 01/12/22.
//
//

import Foundation
import CoreData


extension APOD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<APOD> {
        return NSFetchRequest<APOD>(entityName: "APOD")
    }

    @NSManaged public var date: String?
    @NSManaged public var explanation: String?
    @NSManaged public var hdUrl: String?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var mediaType: String?
    @NSManaged public var thumbnail: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?

}

extension APOD : Identifiable {

}

enum APODMediaType: String {
    case image
    case video
    case unknown
}

extension APOD {
    var APODMediaTypeEnum: APODMediaType {
        if let apodMediaType = APODMediaType(rawValue: mediaType ?? Constants.noSpace) {
              return apodMediaType
          }
          return APODMediaType.unknown
    }
   
    var imageURL: String? {
      switch APODMediaTypeEnum {
      case .image:
          return url
      case .video:
          return thumbnail
      default:
          return nil
      }
   }
}
