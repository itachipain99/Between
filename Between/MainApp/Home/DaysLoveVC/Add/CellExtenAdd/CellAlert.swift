//
//  CellAlert.swift
//  Between
//
//  Created by Nguyễn Minh Hiếu on 3/20/20.
//  Copyright © 2020 Nguyễn Minh Hiếu. All rights reserved.
//

import UIKit

class CellAlert: UITableViewCell {

    @IBOutlet weak var lblAlert: UILabel!
    @IBOutlet weak var imgCheckmark: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgCheckmark.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
