//
//  ItemCollectionViewCell.swift
//  LearningFromBook
//
//  Created by 李天培 on 2017/1/5.
//  Copyright © 2017年 lee. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    var item: (name: String, image: UIImage)? {
        didSet {
            itemImageView.image = item?.image
            itemNameLabel.text = item?.name
        }
    }
    
    @IBOutlet private weak var itemImageView: UIImageView!
    @IBOutlet private weak var itemNameLabel: UILabel!
    
    
}
