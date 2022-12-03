//
//  DetailsTests.swift
//  APODTests
//
//  Created by Bhavesh on 03/12/22.
//

import XCTest
@testable import APOD

class DetailsTests: XCTestCase {
    
    var viewController: DetailsViewController!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "details") as? DetailsViewController
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDetailsScreen() {
        let apod = APOD(context: CoreDataManager.sharedManager.persistentContainer.viewContext)
        apod.mediaType = "image"
        apod.url = "https://apod.nasa.gov/apod/image/2210/Lu20220729-0826_1050.jpg"
        XCTAssertNotNil(apod)
        CoreDataManager.sharedManager.saveContext()
        let viewModel = DetailsViewModel()
        XCTAssertNotNil(viewModel)
        viewController.viewModel = viewModel
        viewController.viewModel?.apod = apod
        viewController.viewModel?.apodImage = UIImage()
        XCTAssertNotNil(viewController.loadViewIfNeeded())
        XCTAssertNotNil(viewController.playVideoURL(UIButton()))
    }
}
