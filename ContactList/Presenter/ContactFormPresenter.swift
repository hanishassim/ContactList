//
//  ContactFormPresenter.swift
//  ContactList
//
//  Created by H on 08/08/2019.
//  Copyright © 2019 H. All rights reserved.
//

import Foundation

protocol ContactFormViewDelegate: class {
    func displayContactPerson(contactInfo: ContactInfo)
    func saveContactPerson()
}

class ContactFormPresenter {
    fileprivate weak var delegate: ContactFormViewDelegate?
    
    func setDelegate(delegate: ContactFormViewDelegate?) {
        self.delegate = delegate
    }
    
    func personInfoSelected(id: String) {
        ContactInfoService.shared.getPersonInfo(id: id) { [weak self] personInfo in
            guard let contactInfo = personInfo else {
                return
            }
            self?.delegate?.displayContactPerson(contactInfo: contactInfo)
        }
    }
    
    func storePersonInfo(contactInfo: ContactInfo) {
        // Save to json file here
        ContactInfoService.shared.setPersonInfo(contactInfo: contactInfo) { [weak self] done in
            if done {
                // Refresh Contact List
                NotificationCenter.default.post(name: Notification.Name.DidSaveContactInfo, object: nil)
                self?.delegate?.saveContactPerson()
            }
        }
    }
}
