//
//  PersonDetailsNameImageCell.swift
//  Interlude
//
//  Created by Gerson Noboa on 03/11/2019.
//  Copyright © 2019 Heavenlapse. All rights reserved.
//

import UIKit

final class PersonDetailsNameImageCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        photoImageView.layer.cornerRadius = photoImageView.frame.height / 2
        photoImageView.image = UIImage(named: "personDetailsImagePlaceholder")
    }
}

