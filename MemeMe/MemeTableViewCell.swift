//
//  MemeTableViewCell.swift
//  MemeMe
//
//  Created by Azeem Mohammad on 11/07/17.
//  Copyright © 2017 Azeem Mohammad. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {

    @IBOutlet weak var memeLabel: UILabel!
    
    
    @IBOutlet weak var memeThumbnail: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
