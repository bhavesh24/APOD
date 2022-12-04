//
//  APODTests.swift
//  APODTests
//
//  Created by Bhavesh on 30/11/22.
//

import XCTest
@testable import APOD

class APODTests: XCTestCase {

    var viewController: APODViewController!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "apod") as? APODViewController
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
    }

    func testAPODScreen() {
        XCTAssertNotNil(viewController.loadViewIfNeeded())
        let apod = APOD(context: CoreDataManager.sharedManager.persistentContainer.viewContext)
        apod.mediaType = "image"
        apod.url = "https://apod.nasa.gov/apod/image/2210/Lu20220729-0826_1050.jpg"
        XCTAssertNotNil(apod)
        viewController.viewModel.currentAPOD = apod
        XCTAssertNotNil(viewController.updateDate())
        XCTAssertNotNil(viewController.playVideoURL(UIButton()))
        XCTAssertNotNil(viewController.viewModel.getDateFromServerDateString(date: "2022-12-03"))
        XCTAssertNotNil(viewController.viewModel.setImage())
        XCTAssertNotNil(viewController.hideLoader())
        XCTAssertNotNil(viewController.updateImage(image: UIImage()))
        XCTAssertNotNil(viewController.hideImageLoader())
        XCTAssertNotNil(viewController.showErrorAlert(message: "Test"))
        XCTAssertNotNil(viewController.viewModel.fetchAPODFromServer(date: "2022-10-01"))
    }

}
