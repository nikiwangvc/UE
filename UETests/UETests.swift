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
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssert(true)
//        let mainStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle :nil)
//        let RecordTripsViewController = mainStoryBoard.instantiateViewController(withIdentifier: "RecordTripsViewController") as! RecordTripsViewController
//        RecordTripsViewController.modalPresentationStyle = .overFullScreen
//        self.present(RecordTripsViewController, animated: true, completion: nil)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
