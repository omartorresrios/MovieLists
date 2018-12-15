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
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    override var isHighlighted: Bool {
        didSet {
            nameLabel.textColor = isHighlighted ? UIColor.red : UIColor.black
        }
    }
    
    override var isSelected: Bool {
        didSet {
            nameLabel.textColor = isSelected ? UIColor.red : UIColor.black
        }
    }
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = .green
        addSubview(nameLabel)
        nameLabel.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
