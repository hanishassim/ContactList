//
//  ContactListPresenter.swift
//  ContactList
//
//  Created by H on 08/08/2019.
//  Copyright © 2019 H. All rights reserved.
//

import Foundation

class ContactListPresenter {
    fileprivate let personInfoService: PersonInfoService
    
    fileprivate weak var contactListViewDelegate: ContactListViewDelegate?
    
    init(personInfoService: PersonInfoService) {
        self.personInfoService = personInfoService
    }
    
    func setViewDelegate(contactListViewDelegate: ContactListViewDelegate?) {
        self.contactListViewDelegate = contactListViewDelegate
    }
    
    func personInfoSelected(id: String) {
        personInfoService.getPersonInfo(id: id) { [weak self] personInfo in
            guard let personInfo = personInfo else {
                return
            }
            print(personInfo.firstName + " " + personInfo.lastName)
            self?.contactListViewDelegate?.displayContactList()
        }
    }
}
