//
//  MenuCell.swift
//  RappiMovieTest
//
//  Created by Omar Torres on 12/14/18.
//  Copyright © 2018 OmarTorres. All rights reserved.
//

import UIKit

class MenuCell: BaseCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        label.textColor = .darkGray
        return label
    }()
    
    override var isHighlighted: Bool {
        didSet {
            nameLabel.textColor = isHighlighted ? baseUIColor : UIColor.darkGray
        }
    }
    
    override var isSelected: Bool {
        didSet {
            nameLabel.textColor = isSelected ? baseUIColor : UIColor.darkGray
        }
    }
    
    override func setupViews() {
        super.setupViews()
        addSubview(nameLabel)
        nameLabel.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
