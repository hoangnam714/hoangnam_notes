//
//  NotesUITests.swift
//  NotesUITests
//
//  Created by admin on 27/11/2023.
//

import XCTest
import Foundation

@testable import Notes

final class NotesUITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLogin() {
        let app = XCUIApplication()
        
        if app.staticTexts["Login"].exists {
            let email = app.textFields["UserName"]
            email.tap()
            _ = email.waitForExistence(timeout: 1)
            email.typeText("Hello1")
            app.keyboards.buttons["Return"].tap()
            
            let password = app.textFields["Password"]
            password.tap()
            _ = password.waitForExistence(timeout: 1)
            password.typeText("1")
            app.keyboards.buttons["Return"].tap()
            app.buttons["SignIn"].tap()
            
            XCTAssertTrue(app.staticTexts["Wrong password"].exists)
            password.tap()
            XCTAssertTrue(password.waitForExistence(timeout: 1))
            password.typeNewText("1111")
            app.keyboards.buttons["Return"].tap()
            app.buttons["SignIn"].tap()
        }
        
    }
    
    func testCreateNote(){
        let app = XCUIApplication()
        app.launch()
        app.buttons["CreateNote"].tap()
        let exp = expectation(description: "Test after 5 seconds")
        _ = XCTWaiter.wait(for: [exp], timeout: 5.0)
        app.buttons["CreateNewNote"].tap()
        
        let failureAlert = app.alerts.firstMatch
        let failureAlertBtn = failureAlert.buttons.firstMatch
        XCTAssertTrue(failureAlert.waitForExistence(timeout: 2), "Name note can't blank")
        failureAlertBtn.tap()
        
        let uuid = UUID().uuidString
        let noteName = "Test note name \(uuid)"
        let description = "Test description \(uuid)"
        let tfNoteName = app.textFields["NoteName"]
        let tfDescription = app.textViews["NoteDescription"]
        tfNoteName.tap()
        _ = tfNoteName.waitForExistence(timeout: 1)
        tfNoteName.typeText(noteName)
        app.keyboards.buttons["Return"].tap()
        tfDescription.tap()
        _ = tfDescription.waitForExistence(timeout: 1)
        tfDescription.typeText(description)
        app.keyboards.buttons["Return"].tap()
        app.buttons["CreateNewNote"].tap()
        
        let successAlert = app.alerts.firstMatch
        let successAlertBtn = successAlert.buttons.firstMatch
        XCTAssertTrue(successAlert.waitForExistence(timeout: 2), "Create note success")
        
        successAlertBtn.tap()
        app.buttons["BackButton"].tap()
        XCTAssertTrue(app.staticTexts[noteName].exists)
    }
}

extension XCUIElement {
    func typeNewText(_ text: String) {
        if let existingText = value as? String, !existingText.isEmpty {
            if existingText != text {
                doubleTap()
            } else {
                return
            }
        }
        typeText(text)
    }
}
