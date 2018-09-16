//
//  HouseCollectionViewCell.swift
//  Westeros
//
//  Created by Alexandre Freire on 16/09/2018.
//  Copyright © 2018 Westeros. All rights reserved.
//

import UIKit

class HouseCollectionViewCell: UICollectionViewCell {

    static let nibName: String = String(describing: self)
    static let defaultReusableIdentifier: String = String(describing: self)
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var wordsLabel: UILabel!
    
    override func prepareForReuse() {
        imageView.image = nil
        nameLabel.text = nil
    }
}
