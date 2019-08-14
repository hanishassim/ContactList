//
//  ContactAvatarTableCell.swift
//  ContactList
//
//  Created by H on 08/08/2019.
//  Copyright © 2019 H. All rights reserved.
//

import UIKit

class ContactAvatarTableCell: TableBaseCell {
    fileprivate lazy var contactImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = accentColor
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    fileprivate let contactImageViewHeight: CGFloat = 98
    fileprivate var contactImageViewHeightConstraint: NSLayoutConstraint!
    
    override func setupCell() {
        contentView.addSubview(contactImageView)
        
        contactImageViewHeightConstraint = NSLayoutConstraint(item: contactImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: contactImageViewHeight)
        
        contactImageViewHeightConstraint.priority = UILayoutPriority(999)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: contactImageView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 16),
            NSLayoutConstraint(item: contactImageView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -32),
            NSLayoutConstraint(item: contactImageView, attribute: .leading, relatedBy: .greaterThanOrEqual, toItem: contentView, attribute: .leading, multiplier: 1, constant: 12),
            NSLayoutConstraint(item: contactImageView, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1, constant: 0),
            
            contactImageViewHeightConstraint,
            NSLayoutConstraint(item: contactImageView, attribute: .height, relatedBy: .equal, toItem: contactImageView, attribute: .width, multiplier: 1, constant: 0)
            ])
        
        contactImageView.layer.cornerRadius = contactImageViewHeight/2
        contactImageView.layer.masksToBounds = true
    }
}
