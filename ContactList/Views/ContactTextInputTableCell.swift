//
//  ContactTextInputTableCell.swift
//  ContactList
//
//  Created by H on 08/08/2019.
//  Copyright © 2019 H. All rights reserved.
//

import UIKit

class ContactTextInputTableCell: TableBaseCell {
    fileprivate lazy var inputNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate lazy var inputTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textColor = .black
        tf.tintColor = accentColor
        tf.clearButtonMode = .whileEditing
        tf.borderStyle = UITextField.BorderStyle.roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    var inputNameText: String {
        get {
            return inputNameLabel.text!
        }
        set (newValue){
            inputNameLabel.text = newValue
        }
    }
    
    var inputText: String? {
        get {
            return inputTextField.text ?? nil
        }
        set (newValue){
             inputTextField.text = newValue
        }
    }
    
    override func setupCell() {
        contentView.addSubview(inputNameLabel)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: inputNameLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 16),
            NSLayoutConstraint(item: inputNameLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 11),
             NSLayoutConstraint(item: inputNameLabel, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: inputNameLabel, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0),
            ])
        
        contentView.addSubview(inputTextField)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: inputTextField, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 112),
            NSLayoutConstraint(item: inputTextField, attribute: .centerY, relatedBy: .equal, toItem: inputNameLabel, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: inputTextField, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -16),
            ])
    }
}
