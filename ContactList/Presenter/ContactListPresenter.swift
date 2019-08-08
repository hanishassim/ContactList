//
//  ContactListPresenter.swift
//  ContactList
//
//  Created by H on 08/08/2019.
//  Copyright © 2019 H. All rights reserved.
//

import Foundation

protocol ContactListViewDelegate: class {
    func displayContactList(list: [PersonInfo])
}

class ContactListPresenter {
    fileprivate let personInfoService: PersonInfoService
    
    fileprivate weak var contactListViewDelegate: ContactListViewDelegate?
    
    init(personInfoService: PersonInfoService) {
        self.personInfoService = personInfoService
    }
    
    func setViewDelegate(contactListViewDelegate: ContactListViewDelegate?) {
        self.contactListViewDelegate = contactListViewDelegate
    }
    
    func personInfoList() {
        personInfoService.getContactList() { [weak self] personInfos in
            guard let personInfos = personInfos else {
                return
            }
            self?.contactListViewDelegate?.displayContactList(list: personInfos)
        }
    }
}
