//
//  APOD+CoreDataClass.swift
//  APOD
//
//  Created by Bhavesh on 01/12/22.
//
//

import Foundation
import CoreData

@objc(APOD)
public class APOD: NSManagedObject, Decodable {
    
    enum CodingKeys: String, CodingKey {
        case date
        case explanation
        case hdUrl = "hdurl"
        case mediaType = "media_type"
        case thumbnail = "thumbnail_url"
        case title
        case url
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        explanation = try? container.decode(String?.self, forKey: .explanation)
        hdUrl = try? container.decode(String?.self, forKey: .hdUrl)
        mediaType = try? container.decode(String?.self, forKey: .mediaType)
        thumbnail = try? container.decode(String?.self, forKey: .thumbnail)
        title = try? container.decode(String?.self, forKey: .title)
        url = try? container.decode(String?.self, forKey: .url)
        date = try? container.decode(String?.self, forKey: .date)
        isFavorite = false
    }
}
