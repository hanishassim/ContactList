//
//  PersonInfoService.swift
//  ContactList
//
//  Created by H on 08/08/2019.
//  Copyright © 2019 H. All rights reserved.
//

import Foundation

class PersonInfoService {
    func loadJSON(completion: @escaping ([PersonInfo]) -> Void) {
        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                //Convert to JSON format
                do {
                    let decoder = JSONDecoder()
                    let jsonResult = try decoder.decode([PersonInfo].self, from: data)
                    
                    completion(jsonResult)
                } catch let	jsonError {
                    print("The file data.json could not be decoded. ", jsonError)
                }
            } catch {
                print("The file data.json could not be loaded")
            }
        }
    }
    
    func getContactList(completion: @escaping ([PersonInfo]?) -> Void) {
        loadJSON { (personInfos) in
            completion(personInfos)
        }
    }
    
    func getPersonInfo(id: String, completion: @escaping (PersonInfo?) -> Void) {
        loadJSON { (personInfos) in
            for personInfo in personInfos {
                print(personInfo.firstName)
                
            }
            
            if let foundPersonInfo = personInfos.first(where: {$0.id == id}) {
                completion(foundPersonInfo)
            } else {
                completion(nil)
            }
        }
    }
}
