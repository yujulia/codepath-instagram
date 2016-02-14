//
//  iTableViewCell.swift
//  Instagram
//
//  Created by Julia Yu on 2/10/16.
//  Copyright © 2016 Julia Yu. All rights reserved.
//

import UIKit
import AFNetworking

class iTableViewCell: UITableViewCell {

    @IBOutlet weak var instaImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
