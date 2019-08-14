//
//  ContactListVC.swift
//  ContactList
//
//  Created by H on 08/08/2019.
//  Copyright © 2019 H. All rights reserved.
//

import UIKit

class ContactListVC: UIViewController {
    fileprivate lazy var tableView: UITableView! = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.estimatedRowHeight = 50
        table.backgroundColor = .white
        table.rowHeight = UITableView.automaticDimension
        table.tableFooterView = UIView(frame: CGRect.zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    fileprivate let contactInfoCellId = "contactInfoCell"
    fileprivate let contactListPresenter = ContactListPresenter()
    fileprivate var contactList: [ContactInfo]? {
        didSet {
            tableView.reloadData()
            tableView.refreshControl?.endRefreshing()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Contacts"
        
        initTableView(tableView: self.tableView)
        
        contactListPresenter.setDelegate(delegate: self)
        
        reloadContactList()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadContactList), name: Notification.Name.DidSaveContactInfo, object: nil)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let addContactNavItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addContactInfo))
        
        navigationItem.rightBarButtonItem = addContactNavItem
    }

    fileprivate func initTableView(tableView: UITableView) {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:  #selector(reloadContactList), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        tableView.register(ContactInfoTableCell.self, forCellReuseIdentifier: contactInfoCellId)
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: tableView, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: .equal, toItem: view, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0),
            NSLayoutConstraint( item: tableView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: .equal, toItem: view, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: .equal, toItem: view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: .equal, toItem: view, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
            ])
    }
    
    @objc func reloadContactList() {
        contactListPresenter.personInfoList()
    }
    
    @objc func addContactInfo() {
        presentContactForm()
    }
    
    fileprivate func presentContactForm(contactInfoId: String? = nil) {
<<<<<<< HEAD
<<<<<<< HEAD
        let vc = ContactFormVC()

        if let contactInfoId = contactInfoId {
            vc.contactInfoId = contactInfoId
        }
=======
        let vc = ContactFormVC(contactInfoId: contactInfoId)
>>>>>>> ea73023... Fix on ContactFormVC UI constraints bug; End commit
=======
        let vc = ContactFormVC(contactInfoId: contactInfoId)
>>>>>>> ea73023... Fix on ContactFormVC UI constraints bug; End commit
        
        let navController = UINavigationController(rootViewController: vc)
        navController.navigationBar.tintColor = accentColor
        present(navController, animated: true, completion: nil)
    }
    
    fileprivate func retainCellState(tableView: UITableView, indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? ContactInfoTableCell else {
            return
        }
        
        cell.retainViewWhenSelected()
    }
}

extension ContactListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: contactInfoCellId, for: indexPath) as? ContactInfoTableCell, let contactList = contactList else {
            return UITableViewCell()
        }
        
        cell.contactNameText = contactList[row].getDisplayName()
        
        return cell
    }
}

extension ContactListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        retainCellState(tableView: tableView, indexPath: indexPath)
        
        let row = indexPath.row
        
        guard let contactList = contactList else {
            return
        }
        
        presentContactForm(contactInfoId: contactList[row].id)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
       retainCellState(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        retainCellState(tableView: tableView, indexPath: indexPath)
    }
}

extension ContactListVC: ContactListViewDelegate {
    func displayContactList(list: [ContactInfo]) {
        contactList = list
    }
}

