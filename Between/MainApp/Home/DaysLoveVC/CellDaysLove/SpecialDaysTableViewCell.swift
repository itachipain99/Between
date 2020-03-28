//
//  YearTableViewCell.swift
//  Between
//
//  Created by Nguyễn Minh Hiếu on 2/16/20.
//  Copyright © 2020 Nguyễn Minh Hiếu. All rights reserved.
//

import UIKit

class SpecialDaysTableViewCell: UITableViewCell {

    @IBOutlet weak var imgYear: UIImageView!
    @IBOutlet weak var lblSpecial: UILabel!
    @IBOutlet weak var lblCalendarDays: UILabel!
    @IBOutlet weak var lblDaysLeft: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

    
}
