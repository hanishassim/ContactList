//
//  PersonInfoService.swift
//  ContactList
//
//  Created by H on 08/08/2019.
//  Copyright © 2019 H. All rights reserved.
//

import Foundation

class ContactInfoService {
    static let shared = ContactInfoService()
    
    private init() { }

    // MARK: - ContactInfo getter and setter functions
    func getContactList(completion: contactListCompletion) {
        loadJsonDocument { (personInfos) in
            completion(personInfos)
        }
    }
    
    func getPersonInfo(id: String, completion: (_ contactList: ContactInfo?) -> Void) {
        loadJsonDocument { (personInfos) in
            if let foundPersonInfo = personInfos.first(where: {$0.id == id}) {
                completion(foundPersonInfo)
            } else {
                completion(nil)
            }
        }
    }
    
    func setPersonInfo(contactInfo: ContactInfo, completion: @escaping (Bool) -> Void) {
        storeJSON(contactInfo: contactInfo) { (done) in
            completion(done)
        }
    }
    
    // MARK:- To copy JSON to Documents folder (Local Storage) to enable CRUD
    func copyJsonIfNeeded() {
        let fileManager = FileManager.default
        
        do {
            let filename = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("data").appendingPathExtension("json")
            
            if !( (try? filename.checkResourceIsReachable()) ?? false) {
                print("data.json does not exist in documents folder")
                
                let documentsURL = Bundle.main.resourceURL?.appendingPathComponent("data").appendingPathExtension("json")
                
                do {
                    try fileManager.copyItem(atPath: (documentsURL?.path)!, toPath: filename.path)
                } catch let error as NSError {
                    print("Couldn't copy file to final location! Error:\(error.description)")
                }
                
            } else {
                print("data.json file found at path: \(filename.path)")
            }
        } catch {
            print("The file data.json does not exist in documents folder")
        }
    }
    
    // MARK:- To decode JSON file to conform by ContactInfo object
    fileprivate func decodeFileToContactInfo(_ filename: URL, _ completion: ([ContactInfo]) -> Void) throws {
        let data = try Data(contentsOf: URL(fileURLWithPath: filename.path), options: .mappedIfSafe)
        //Convert to JSON format
        do {
            let decoder = JSONDecoder()
            let jsonResult = try decoder.decode([ContactInfo].self, from: data)
            
            completion(jsonResult)
        } catch let jsonError {
            print("The file data.json could not be decoded. ", jsonError)
        }
    }
    
    // MARK: To load JSON from Documents folder (Local Storage)
    fileprivate func loadJsonDocument(completion: contactListCompletion) {
        do {
            let filename = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("data").appendingPathExtension("json")
            
            try decodeFileToContactInfo(filename, completion)
        } catch {
            print("The data could not be encoded to json")
        }
    }
    
    // MARK: To store/save JSON on Documents folder (Local Storage)
    fileprivate func storeJSON(contactInfo: ContactInfo, completion: @escaping (Bool) -> Void) {
        // Load existing contactList, and append to end, or to edit current contactInfo data
        loadJsonDocument { (contactList: [ContactInfo]) in
            var list = contactList

            if let row = contactList.firstIndex(where: {$0.id == contactInfo.id}) {
                // Update contactInfo
                list[row] = contactInfo
            } else {
                // Create new contactInfo
                list.append(contactInfo)
            }
            
            let encoder = JSONEncoder()

            do {
                let jsonData = try encoder.encode(list)
                guard let jsonString = String(data: jsonData, encoding: .utf8) else {
                    completion(false)
                    return
                }
                
                let fileManager = FileManager.default
                
                let filename = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("data").appendingPathExtension("json")
                
                if fileManager.fileExists(atPath: filename.path) {
                    do {
                        //Remove current file and re-create it
                        try fileManager.removeItem(at: filename)

                        fileManager.createFile(atPath: filename.path, contents: jsonData, attributes: nil)
                        
                        completion(true)
                    } catch let error {
                        print("Can't open fileHandle \(error)")
                    }
                } else {
                    do {
                        try jsonString.write(to: filename, atomically: true, encoding: .utf8)
                        
                        completion(true)
                    } catch let error {
                        // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
                        print("The file could not be written ", error)
                    }
                }
            } catch {
                print("The data could not be encoded to json")
            }
        }
    }
}
