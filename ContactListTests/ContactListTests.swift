//
//  ContactListTests.swift
//  ContactListTests
//
//  Created by H on 14/08/2019.
//  Copyright © 2019 H. All rights reserved.
//

import XCTest

@testable import ContactList
class ContactListTests: XCTestCase {
    func testLoadJSONDocument() {
        // Define an expectation
        let resultExpectation = expectation(description: "ContactInfoService does getContactList and runs the callback closure")
        
        // Exercise the asynchronous code
        ContactInfoService.shared.getContactList { (contacList) in
            XCTAssertGreaterThan(contacList.count, 0)
            XCTAssertEqual(contacList.first!.firstName, "Phoebe")
            // Fulfill the expectation in the async callback
            resultExpectation.fulfill()
        }
        
        // Wait for the expectation to be fulfilled
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout: \(error)")
            }
        }
    }
    
    func testSaveContactInfo() {
        let ci = ContactInfo(id: "12345", firstName: "Dan", lastName: "Cooper", email: "dan.c@email.com", phone: nil)
        
        ContactInfoService.shared.setPersonInfo(contactInfo: ci) { (done) in
            if done {
                ContactInfoService.shared.getPersonInfo(id: "12345", completion: { (contactInfo) in
                    if contactInfo != nil {
                        XCTAssertEqual(contactInfo?.email, "dan.c@email.com")
                        return
                    }
                    XCTFail("SavePersonInfo failed")
                })
                return
            }
            XCTFail("SaveContactInfo failed")
        }
    }
}
