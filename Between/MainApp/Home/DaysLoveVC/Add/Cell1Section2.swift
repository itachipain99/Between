//
//  TableViewCell2InsideCell3.swift
//  Between
//
//  Created by Nguyễn Minh Hiếu on 2/18/20.
//  Copyright © 2020 Nguyễn Minh Hiếu. All rights reserved.
//

import UIKit

class Cell1Section2: UITableViewCell {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var view: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        datePicker.addTarget(self, action: #selector(date), for: .allEvents)
    }
    
    @objc func date(){
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "EEE,MMM dd,yyyy"
        let dateForm = dateFormat.string(from: datePicker.date)
        lblDate.text = dateForm
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
