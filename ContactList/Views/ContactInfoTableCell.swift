//
//  ContactInfoTableCell.swift
//  ContactList
//
//  Created by H on 08/08/2019.
//  Copyright © 2019 H. All rights reserved.
//

import UIKit

class ContactInfoTableCell: TableBaseCell {
    fileprivate lazy var contactImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = accentColor
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    fileprivate lazy var contactNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var contactNameText = String() {
        didSet {
            contactNameLabel.text = contactNameText
        }
    }
    
    fileprivate let contactImageViewHeight: CGFloat = 49
    fileprivate var contactImageViewHeightConstraint: NSLayoutConstraint!
    
    override func setupCell() {
        backgroundColor = .white
        
        contentView.addSubview(contactImageView)
        
        contactImageViewHeightConstraint = NSLayoutConstraint(item: contactImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: contactImageViewHeight)
        
        contactImageViewHeightConstraint.priority = UILayoutPriority(999)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: contactImageView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 8),
            NSLayoutConstraint(item: contactImageView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 12),
            NSLayoutConstraint(item: contactImageView, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0),
            
            contactImageViewHeightConstraint,
            NSLayoutConstraint(item: contactImageView, attribute: .height, relatedBy: .equal, toItem: contactImageView, attribute: .width, multiplier: 1, constant: 0)
            ])
        
        contactImageView.layer.cornerRadius = contactImageViewHeight/2
        contactImageView.layer.masksToBounds = true
        
        contentView.addSubview(contactNameLabel)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: contactNameLabel, attribute: .leading, relatedBy: .equal, toItem: contactImageView, attribute: .trailing, multiplier: 1, constant: 8),
            NSLayoutConstraint(item: contactNameLabel, attribute: .centerY, relatedBy: .equal, toItem: contactImageView, attribute: .centerY, multiplier: 1, constant: 0),
            ])
    }
    
    func retainViewWhenSelected() {
        contactImageView.backgroundColor = accentColor
    }
}
