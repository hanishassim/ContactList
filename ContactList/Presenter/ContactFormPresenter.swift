//
//  ContactFormPresenter.swift
//  ContactList
//
//  Created by H on 08/08/2019.
//  Copyright © 2019 H. All rights reserved.
//

import Foundation

protocol ContactFormViewDelegate: class {
    func displayContactPerson(contactInfo: PersonInfo)
    func saveContactPerson()
}

class ContactFormPresenter {
    fileprivate let personInfoService: PersonInfoService
    
    fileprivate weak var delegate: ContactFormViewDelegate?
    
    init(personInfoService: PersonInfoService) {
        self.personInfoService = personInfoService
    }
    
    func setViewDelegate(delegate: ContactFormViewDelegate?) {
        self.delegate = delegate
    }
    
    func personInfoSelected(id: String) {
        personInfoService.getPersonInfo(id: id) { [weak self] personInfo in
            guard let contactInfo = personInfo else {
                return
            }
            self?.delegate?.displayContactPerson(contactInfo: contactInfo)
        }
    }
    
    func storePersonInfo(contactInfo: PersonInfo) {
        // Save to json file here
        personInfoService.setPersonInfo(contactInfo: contactInfo) { [weak self] done in
            if done {
                self?.delegate?.saveContactPerson()
            }
        }
    }
}
