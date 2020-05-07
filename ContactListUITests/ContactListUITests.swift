//
//  ContactListUITests.swift
//  ContactListUITests
//
//  Created by H on 14/08/2019.
//  Copyright © 2019 H. All rights reserved.
//

import XCTest

class ContactListUITests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    func testModalWindow() {
        let app = XCUIApplication()
        
        app.navigationBars.buttons["Add"].tap()
        XCTAssert(app.navigationBars.buttons["Cancel"].exists)
        XCTAssert(app.navigationBars.buttons["Save"].exists)
        
        app.navigationBars.buttons["Cancel"].tap()
        XCTAssert(app.navigationBars["Contacts"].exists)
    }

    fileprivate func checkIfTestFieldIsFirstResponder(textField: XCUIElement) -> Bool {
        return (textField.value(forKey: "hasKeyboardFocus") as? Bool) ?? false
    }
    
    func testRequiredFieldAlert() {
        let app = XCUIApplication()
        
        app.navigationBars.buttons["Add"].tap()
        app.buttons["Save"].tap()
        XCTAssert(app.alerts.element.staticTexts["Error"].exists)
        XCTAssert(app.alerts.element.staticTexts["First Name and Last Name is required."].exists)
    }
    
    func testTextFieldFocusAndKeyboardReturnButton() {
        let app = XCUIApplication()
        
        app.navigationBars.buttons["Add"].tap()
        
        let tablesCells = app.tables.cells
        
        tablesCells.containing(.staticText, identifier:"First Name").children(matching: .textField).element.tap()
        XCTAssert(app.keyboards.count > 0, "The keyboard is not shown")
        
        guard app.keyboards.count > 0 else { return }
        
        let nextButton = app/*@START_MENU_TOKEN@*/.buttons["Next:"]/*[[".keyboards",".buttons[\"Next\"]",".buttons[\"Next:\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        
        nextButton.tap()
        XCTAssert(checkIfTestFieldIsFirstResponder(textField:tablesCells.containing(.staticText, identifier:"Last Name").children(matching: .textField).element))
        
        nextButton.tap()
        XCTAssert(checkIfTestFieldIsFirstResponder(textField: tablesCells.containing(.staticText, identifier:"Email").children(matching: .textField).element))
        
        nextButton.tap()
        XCTAssert(checkIfTestFieldIsFirstResponder(textField: tablesCells.containing(.staticText, identifier:"Phone").children(matching: .textField).element))
    }
}
