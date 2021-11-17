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

    func testRecordTripsViewController() throws {
        // https://stackoverflow.com/questions/53756455/how-to-write-unit-test-for-button-tap
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let RecordTripsViewController = mainStoryBoard   .instantiateViewController(withIdentifier: "RecordTripsViewController") as! RecordTripsViewController
        RecordTripsViewController.loadViewIfNeeded()
        let window = UIWindow()
        window.rootViewController = RecordTripsViewController
        print("rootViewController \(UIApplication.shared.keyWindow?.rootViewController)")
        window.makeKeyAndVisible()
        RecordTripsViewController.view.layoutIfNeeded()
        // https://developer.apple.com/forums/thread/107239
        RecordTripsViewController.RecordTrip(self) // start recording trip
        // https://stackoverflow.com/questions/40073738/how-to-get-the-current-title-of-a-button-in-swift-3-0-ios-using-sender-titlefo
        XCTAssertEqual(RecordTripsViewController.RecordTripButton.currentTitle!, "Stop Trip")
        RecordTripsViewController.RecordTrip(self) // stop recording trip
        XCTAssertEqual(RecordTripsViewController.RecordTripButton.currentTitle!, "Start Trip")
        RecordTripsViewController.Friends(self)
        print("rootViewController \(UIApplication.shared.keyWindow?.rootViewController)")
        print("Presented \(RecordTripsViewController.presentedViewController!.restorationIdentifier)")
//        print("Presenting \(RecordTripsViewController.presentingViewController)")
        print("rootViewController \(UIApplication.shared.keyWindow?.rootViewController)")
        XCTAssertEqual(RecordTripsViewController.presentedViewController!.restorationIdentifier, "FriendsViewController")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
