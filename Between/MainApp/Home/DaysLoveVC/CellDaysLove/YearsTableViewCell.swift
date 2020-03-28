//
//  SpecialDaysTableViewCell.swift
//  Between
//
//  Created by Nguyễn Minh Hiếu on 2/16/20.
//  Copyright © 2020 Nguyễn Minh Hiếu. All rights reserved.
//

import UIKit

class YearsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblYears: UILabel!
    @IBOutlet weak var lblDaysLeft: UILabel!
    @IBOutlet weak var lblDayLeftCalendar: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
