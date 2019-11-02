//
//  PersonListCell.swift
//  Interlude
//
//  Created by Gerson Noboa on 02/11/2019.
//  Copyright © 2019 Heavenlapse. All rights reserved.
//

import UIKit

final class PersonListCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var organizationLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    
    override func awakeFromNib() {
        nameLabel.font = UIFont.systemFont(ofSize: 22)
        organizationLabel.font = UIFont.systemFont(ofSize: 18)
        followersLabel.font = UIFont.systemFont(ofSize: 16)
    }
}
