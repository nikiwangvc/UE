//
//  UETests.swift
//  UETests
//
//  Created by Niki Wang on 10/25/21.
//

import XCTest
@testable import UE

class UETests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
    }
    

    func testThatDistanceUpdatesWhenStartPressed() throws {
        // https://stackoverflow.com/questions/53756455/how-to-write-unit-test-for-button-tap
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let RecordTripsViewController = mainStoryboard   .instantiateViewController(withIdentifier: "RecordTripsViewController") as! RecordTripsViewController
        RecordTripsViewController.loadViewIfNeeded()
        RecordTripsViewController.RecordTrip(self)
//        RecordTripsViewController.RecordTripButton?.sendActions(for: .touchUpInside)
        // https://stackoverflow.com/questions/40073738/how-to-get-the-current-title-of-a-button-in-swift-3-0-ios-using-sender-titlefo
        XCTAssertEqual(RecordTripsViewController.RecordTripButton.currentTitle!, "Stop Trip")
//        XCTAssertTrue(true)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
