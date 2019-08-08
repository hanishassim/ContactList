//
//  PersonInfo.swift
//  ContactList
//
//  Created by H on 08/08/2019.
//  Copyright © 2019 H. All rights reserved.
//

import Foundation

struct PersonInfo: Decodable {
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    let phone: String
}
