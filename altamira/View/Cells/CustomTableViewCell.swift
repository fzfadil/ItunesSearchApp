//
//  CustomTableViewCell.swift
//  altamira
//
//  Created by recep daban on 5.08.2019.
//  Copyright © 2019 com. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var resultTitle: UILabel!
    @IBOutlet weak var resultKind: UILabel!
    @IBOutlet weak var resultImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
