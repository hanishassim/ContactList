//
//  PersonInfo.swift
//  ContactList
//
//  Created by H on 08/08/2019.
//  Copyright © 2019 H. All rights reserved.
//

import Foundation

struct ContactInfo: Codable {
    let id: String
    let firstName: String
    let lastName: String
    let email: String?
    let phone: String?
    
    init(id: String?, firstName: String, lastName: String, email: String?, phone: String?) {
        self.id = id ?? RandomCodeGenerator().randomString()
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phone = phone
    }
    
    func getDisplayName() -> String {
        return firstName + " " + lastName
    }
}
