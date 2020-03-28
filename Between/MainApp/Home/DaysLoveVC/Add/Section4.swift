//
//  Cell5TableViewCell.swift
//  Between
//
//  Created by Nguyễn Minh Hiếu on 2/18/20.
//  Copyright © 2020 Nguyễn Minh Hiếu. All rights reserved.
//

import UIKit

class Section4: UITableViewCell {

    @IBOutlet weak var textView: UITextView!
    
    weak var parentVC : AddSpecialViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textView.delegate = self

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension Section4 : UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        parentVC!.isTapNote = true
        parentVC?.addTableView.isScrollEnabled = false
        parentVC?.addTableView.beginUpdates()
        parentVC?.addTableView.endUpdates()
    }
}
