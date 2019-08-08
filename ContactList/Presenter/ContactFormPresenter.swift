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
    func saveContactPerson(contactInfo: PersonInfo)
}

class ContactFormPresenter {
    fileprivate let personInfoService: PersonInfoService
    
    fileprivate weak var contactFormViewDelegate: ContactFormViewDelegate?
    
    init(personInfoService: PersonInfoService) {
        self.personInfoService = personInfoService
    }
    
    func setViewDelegate(contactFormViewDelegate: ContactFormViewDelegate?) {
        self.contactFormViewDelegate = contactFormViewDelegate
    }
    
    func personInfoSelected(id: String) {
        personInfoService.getPersonInfo(id: id) { [weak self] personInfo in
            guard let contactInfo = personInfo else {
                return
            }
            self?.contactFormViewDelegate?.displayContactPerson(contactInfo: contactInfo)
        }
    }
}
