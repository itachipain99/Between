//
//  CalendarViewController.swift
//  Between
//
//  Created by Nguyễn Minh Hiếu on 2/15/20.
//  Copyright © 2020 Nguyễn Minh Hiếu. All rights reserved.
//

import UIKit
import  JTAppleCalendar

class CalendarViewController: UIViewController {

    
    var isRotation = false
    var g : CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btn_Close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btn_add(_ sender: UIButton) {
        if !isRotation{
            g += 90
            UIView.animate(withDuration: 0.3, animations: {
                self.navigationItem.rightBarButtonItem?.customView?.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI)*self.g/180)
                sender.setImage(UIImage(systemName: "xmark"), for: .normal)
                sender.tintColor = .black
            }) { (ok) in
                self.isRotation = true
            }
        }
        else {
            g -= 90
            UIView.animate(withDuration: 0.3, animations: {
                self.navigationItem.rightBarButtonItem?.customView?.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI)*self.g/180)
                sender.setImage(UIImage(systemName: "plus"), for: .normal)
                sender.tintColor = colorApp
            }) { (ok) in
                self.isRotation = false
            }
        }
    }
    

}
