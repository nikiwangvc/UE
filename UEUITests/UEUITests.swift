//
//  UEUITests.swift
//  UEUITests
//
//  Created by Niki Wang on 10/25/21.
//

import XCTest

class UEUITests: XCTestCase {
    var app: XCUIApplication!
    
    // https://www.hackingwithswift.com/articles/148/xcode-ui-testing-cheat-sheet
    // ^ this link is helpful
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLogin() throws{
        app.launch()
        
    }
    
    
    func testExample() throws {
        // UI tests must launch the application that they test.
        app.launch()
        
        // https://uxdesign.cc/your-first-uitest-in-swift-847bc5595c26
        let recordTripButton = app.buttons["RecordTripButton"]
        XCTAssertFalse(recordTripButton.isSelected)
        recordTripButton.tap()
        XCTAssertEqual("Stop Trip", recordTripButton.label)
//        XCTAssertTrue(recordTripButton.isSelected)
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
