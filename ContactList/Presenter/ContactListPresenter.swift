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
    
    fileprivate weak var delegate: ContactListViewDelegate?
    
    init(personInfoService: PersonInfoService) {
        self.personInfoService = personInfoService
    }
    
    func setViewDelegate(delegate: ContactListViewDelegate?) {
        self.delegate = delegate
    }
    
    func personInfoList() {
        personInfoService.getContactList() { [weak self] personInfos in
            self?.delegate?.displayContactList(list: personInfos)
        }
    }
}
