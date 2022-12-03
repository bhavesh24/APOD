//
//  FavoritesTests.swift
//  APODTests
//
//  Created by Bhavesh on 03/12/22.
//

import XCTest
@testable import APOD
import CoreData

class FavoritesTests: XCTestCase {

    var viewController: FavoritesViewController!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "favorites") as? FavoritesViewController
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        CoreDataManager.sharedManager.deleteAllUnitTestsAPODS()
    }
    
    func testFavoritesScreen() {
        XCTAssertNotNil(viewController.loadViewIfNeeded())
        let apod = APOD(context: CoreDataManager.sharedManager.persistentContainer.viewContext)
        apod.mediaType = "image"
        apod.url = "https://apod.nasa.gov/apod/image/2210/Lu20220729-0826_1050.jpg"
        apod.isFavorite = true
        XCTAssertNotNil(apod)
        CoreDataManager.sharedManager.saveContext()
        XCTAssertNotNil(viewController.viewWillAppear(true))
        if let collectionView = viewController.view.subviews.first(where: { view in
            view is UICollectionView
        }) as? UICollectionView {
            XCTAssertNotNil(viewController.collectionView(collectionView, cellForItemAt: IndexPath(item: 0, section: 0)))
            XCTAssertNotNil(viewController.collectionView(collectionView, didSelectItemAt: IndexPath(item: 0, section: 0)))
        }
        XCTAssertNotNil(viewController.removeFavorites(tag: 0))
    }

}

extension CoreDataManager {
    
    func deleteAllUnitTestsAPODS() {
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<APOD> = APOD.fetchRequest()
        let predicateURL = "https://apod.nasa.gov/apod/image/2210/Lu20220729-0826_1050.jpg"
        fetchRequest.predicate = NSPredicate(format: "url = %@", predicateURL as CVarArg)
        let context = persistentContainer.viewContext
        do {
            // Execute Fetch Request
            let results = try context.fetch(fetchRequest)
            for object in results {
                persistentContainer.viewContext.delete(object)
            }
            saveContext()
        } catch {
            print("Unable to Execute Fetch Request, \(error)")
        }
    }
}
