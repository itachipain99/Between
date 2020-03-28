//
//  TableDaysLove.swift
//  Between
//
//  Created by Nguyễn Minh Hiếu on 2/19/20.
//  Copyright © 2020 Nguyễn Minh Hiếu. All rights reserved.
//

import UIKit

class TableView : UITableView {
    
    var contentSizeDidChange: ((_ size: CGSize) -> ())?
    
    override var contentSize: CGSize {
        didSet{
            contentSizeDidChange?(contentSize)
        }
    }
}
