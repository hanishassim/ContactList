//
//  ContactListPresenter.swift
//  ContactList
//
//  Created by H on 08/08/2019.
//  Copyright © 2019 H. All rights reserved.
//

import Foundation

protocol ContactListViewDelegate: class {
    func displayContactList(list: [ContactInfo])
}

class ContactListPresenter {
    fileprivate weak var delegate: ContactListViewDelegate?
    
    func setDelegate(delegate: ContactListViewDelegate?) {
        self.delegate = delegate
    }
    
    func personInfoList() {
        ContactInfoService.shared.getContactList() { [weak self] personInfos in
            self?.delegate?.displayContactList(list: personInfos)
        }
    }
}
