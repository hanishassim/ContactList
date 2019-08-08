//
//  ContactFormVC.swift
//  ContactList
//
//  Created by H on 08/08/2019.
//  Copyright © 2019 H. All rights reserved.
//

import UIKit

class ContactFormVC: UIViewController {
    fileprivate lazy var tableView: UITableView! = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.estimatedRowHeight = 50
        table.rowHeight = UITableView.automaticDimension
        table.tableFooterView = UIView(frame: CGRect.zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    fileprivate let contactAvatarCellId = "contactAvatarCell"
    fileprivate let contactInputFieldCellId = "contactInputFieldCell"
    fileprivate let contactFormPresenter = ContactFormPresenter(personInfoService: PersonInfoService())
    fileprivate var contactInfo: PersonInfo? {
        didSet {
            tableView.reloadData()
        }
    }
    
    var contactInfoId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initTableView(tableView: self.tableView)
        
        contactFormPresenter.setViewDelegate(delegate: self)

        guard let contactInfoId = contactInfoId else {
            return
        }
        
        contactFormPresenter.personInfoSelected(id: contactInfoId)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let cancelButtonNavItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancelAction))
        let saveButtonNavItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveContactInfoAction))
        
        navigationItem.leftBarButtonItem = cancelButtonNavItem
        navigationItem.rightBarButtonItem = saveButtonNavItem
    }
    
    fileprivate func initTableView(tableView: UITableView) {
        tableView.register(ContactAvatarTableCell.self, forCellReuseIdentifier: contactAvatarCellId)
        tableView.register(ContactTextInputTableCell.self, forCellReuseIdentifier: contactInputFieldCellId)
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: tableView, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: .equal, toItem: view, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0),
            NSLayoutConstraint( item: tableView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: .equal, toItem: view, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: .equal, toItem: view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: .equal, toItem: view, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
            ])
    }
    
    @objc func cancelAction() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func saveContactInfoAction() {
        guard let firstNameCell = tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as? ContactTextInputTableCell, let lastNameCell = tableView.cellForRow(at: IndexPath(row: 1, section: 1)) as? ContactTextInputTableCell, let firstName = firstNameCell.inputText, !firstName.isEmpty, let lastName = lastNameCell.inputText, !lastName.isEmpty else {
            let alertController = UIAlertController(title: "Error", message: "First Name and Last Name is required.", preferredStyle: .alert)
            alertController.view.tintColor = accentColor
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
            return
        }
        
        let emailCell = tableView.cellForRow(at: IndexPath(row: 0, section: 2)) as? ContactTextInputTableCell
        let phoneCell = tableView.cellForRow(at: IndexPath(row: 1, section: 2)) as? ContactTextInputTableCell
        
        let newContact = PersonInfo(id: contactInfoId ?? RandomCodeGenerator().randomString(), firstName: firstName, lastName: lastName, email: emailCell?.inputText, phone: phoneCell?.inputText)
        
        contactFormPresenter.storePersonInfo(contactInfo: newContact)
    }
}

extension ContactFormVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1, 2:
            return 2
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let section = indexPath.section
        
        switch section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: contactAvatarCellId, for: indexPath) as? ContactAvatarTableCell else {
                return UITableViewCell()
            }
            
            cell.selectionStyle = .none
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: contactInputFieldCellId, for: indexPath) as? ContactTextInputTableCell else {
                return UITableViewCell()
            }
            
            cell.selectionStyle = .none
            
            switch row {
            case 0:
                cell.inputNameText = "First Name"
                cell.inputText = contactInfo?.firstName ?? nil
            case 1:
                cell.inputNameText = "Last Name"
                cell.inputText = contactInfo?.lastName ?? nil
            default: break
            }
            
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: contactInputFieldCellId, for: indexPath) as? ContactTextInputTableCell else {
                return UITableViewCell()
            }
            
            cell.selectionStyle = .none
            
            switch row {
            case 0:
                cell.inputNameText = "Email"
                cell.inputText = contactInfo?.email ?? nil
            case 1:
                cell.inputNameText = "Phone"
                cell.inputText = contactInfo?.phone ?? nil
            default: break
            }
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return "Main Information"
        case 2:
            return "Sub Information"
        default:
            return nil
        }
    }
}

extension ContactFormVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension ContactFormVC: ContactFormViewDelegate {
    func displayContactPerson(contactInfo: PersonInfo) {
        self.contactInfo = contactInfo
    }
    
    func saveContactPerson() {
        cancelAction()
    }
}
