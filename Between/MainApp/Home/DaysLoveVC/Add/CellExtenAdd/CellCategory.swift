//
//  CellCategory.swift
//  Between
//
//  Created by Nguyễn Minh Hiếu on 3/20/20.
//  Copyright © 2020 Nguyễn Minh Hiếu. All rights reserved.
//

import UIKit

class CellCategory: UITableViewCell {

    @IBOutlet weak var imgCategory: UIImageView!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var imgCheckmark: UIImageView!
       
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgCheckmark.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    //    imgCheckmark.isHidden = false
        // Configure the view for the selected state
    }

}
