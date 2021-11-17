//
//  UEUITests.swift
//  UEUITests
//
//  Created by Niki Wang on 10/25/21.
//

import XCTest

class UEUITests: XCTestCase {
    var app: XCUIApplication!
    
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
    
        //login functionality
        app.textFields["Email"].tap()
        app.textFields["Password"].tap()
       
        app.buttons["Get Started"].tap()
        app.otherElements["RecordTripsView"].tap()
        //logout button is on the home page
        //indicates signing in successfully
        app/*@START_MENU_TOKEN@*/.staticTexts["Logout"]/*[[".otherElements[\"RecordTripsView\"]",".buttons[\"Logout\"].staticTexts[\"Logout\"]",".staticTexts[\"Logout\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        //Don't have an account functionality
        app/*@START_MENU_TOKEN@*/.staticTexts["Don't have an account?"]/*[[".buttons[\"Don't have an account?\"].staticTexts[\"Don't have an account?\"]",".staticTexts[\"Don't have an account?\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        //Navigate to signUp page
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.tap()
        app.buttons["Sign Up"].tap()
        app.alerts["Attention"].scrollViews.otherElements.buttons["OK"].tap()
        
    }
    
    func testSignup() throws{
        app.launch()
        
        //SignUp for a new account
        XCUIApplication()/*@START_MENU_TOKEN@*/.staticTexts["Don't have an account?"]/*[[".buttons[\"Don't have an account?\"].staticTexts[\"Don't have an account?\"]",".staticTexts[\"Don't have an account?\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Don't have an account?"]/*[[".buttons[\"Don't have an account?\"].staticTexts[\"Don't have an account?\"]",".staticTexts[\"Don't have an account?\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.textFields["Email"].tap()
        app.textFields["Password"].tap()
        
        app.buttons["Sign Up"].tap()
        //logout button is on the home page
        //indicates signing up successfully
        app/*@START_MENU_TOKEN@*/.staticTexts["Logout"]/*[[".otherElements[\"RecordTripsView\"]",".buttons[\"Logout\"].staticTexts[\"Logout\"]",".staticTexts[\"Logout\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        //Already have an account
        app/*@START_MENU_TOKEN@*/.staticTexts["Already have an account? Login"]/*[[".buttons[\"Already have an account? Login\"].staticTexts[\"Already have an account? Login\"]",".staticTexts[\"Already have an account? Login\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        //login page: "Get started" is a login button
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Get Started"]/*[[".buttons[\"Get Started\"].staticTexts[\"Get Started\"]",".staticTexts[\"Get Started\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.alerts["Attention"].scrollViews.otherElements.buttons["OK"].tap()
        
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
