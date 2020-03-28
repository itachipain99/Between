//
//  ViewHeaderY.swift
//  Between
//
//  Created by Nguyễn Minh Hiếu on 2/19/20.
//  Copyright © 2020 Nguyễn Minh Hiếu. All rights reserved.
//

import UIKit

class ViewHeaderY: UITableViewCell {

    @IBOutlet weak var imgPerson1: UIImageView!
    @IBOutlet weak var imgPerson2: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDays: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
