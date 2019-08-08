//
//  PersonInfo.swift
//  ContactList
//
//  Created by H on 08/08/2019.
//  Copyright © 2019 H. All rights reserved.
//

import Foundation

struct PersonInfo: Codable {
    let id: String
    let firstName: String
    let lastName: String
    let email: String?
    let phone: String?
    
//    private enum CodingKeys: String, CodingKey {
//        case id, firstName, lastName, email, phone
//    }
    
    func getDisplayName() -> String {
        return firstName + " " + lastName
    }
    
//    public func encode(to encoder: Encoder) throws {
//        do {
//            var container = encoder.container(keyedBy: CodingKeys.self)
//            try container.encode(id, forKey: .id)
//            try container.encode(firstName, forKey: .firstName)
//            try container.encode(lastName, forKey: .lastName)
//            try container.encode(email, forKey: .email)
//            try container.encode(phone, forKey: .phone)
//        } catch {
//            fatalError("encode failed. ")
//        }
//    }
}
