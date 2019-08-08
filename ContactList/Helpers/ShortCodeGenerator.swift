//
//  ShortCodeGenerator.swift
//  ContactList
//
//  Created by H on 08/08/2019.
//  Copyright © 2019 H. All rights reserved.
//

import Foundation

struct ShortCodeGenerator {
    fileprivate static let base62chars = "0123456789abcdefghijklmnopqrstuvwxyz"
    fileprivate static let maxBase: UInt32 = 62
    
//    static func getCode(withBase base: UInt32 = maxBase, length: Int) -> String {
//        var code = ""
//        let base = min(base, maxBase)
//        for _ in 0..<length {
//            let rand = Int(arc4random_uniform(base))
//            code.append(base62chars[rand])
//        }
//        return code
//    }
}
