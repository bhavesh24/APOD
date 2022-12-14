//
//  CoreDataManager.swift
//  APOD
//
//  Created by Bhavesh on 01/12/22.
//

import Foundation
import CoreData

final class CoreDataManager {

    // MARK: - Properties
    private static let modelName: String = "APOD"
    
    static let sharedManager = CoreDataManager()

    // MARK: - Initialization
    private init() {
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: CoreDataManager.modelName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

extension CoreDataManager {
    
    func fetchSavedAPODFor(date: String) -> APOD? {
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<APOD> = APOD.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date = %@", date as CVarArg)
        let context = persistentContainer.viewContext
        do {
            // Execute Fetch Request
            let apod = try context.fetch(fetchRequest).first
            return apod
        } catch {
            print("Unable to Execute Fetch Request, \(error)")
        }
        return nil
    }
    
    func fetchAPODFavorites() -> [APOD]? {
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<APOD> = APOD.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isFavorite = YES")
        let context = persistentContainer.viewContext
        do {
            // Execute Fetch Request
            let results = try context.fetch(fetchRequest)
            return results

        } catch {
            print("Unable to Execute Fetch Request, \(error)")
        }
        return nil
    }
}
