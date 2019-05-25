//
//  VLCollectionViewCell.swift
//  VideoListDemo
//
//  Created by Tibin Thomas on 24/05/19.
//  Copyright © 2019 tibint. All rights reserved.
//

import UIKit

class VLCollectionViewCell:UICollectionViewCell{
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setGradient()
    }
    
    private func setGradient()  {
        let gradient = CAGradientLayer()
        gradient.frame = self.contentView.bounds
        gradient.colors = [UIColor.cyan.cgColor, UIColor.brown.cgColor]
        gradient.masksToBounds = false
        gradient.cornerRadius = 12
        contentView.layer.insertSublayer(gradient, at: 0)
    }

}


