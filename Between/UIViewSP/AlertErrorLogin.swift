//
//  AlertErrorLogin.swift
//  Between
//
//  Created by Nguyễn Minh Hiếu on 2/2/20.
//  Copyright © 2020 Nguyễn Minh Hiếu. All rights reserved.
//

import UIKit

class AlertErrorLogin : UIView{
    
    static let alert = AlertErrorLogin()
    
    @IBOutlet var errorView: UIView!
    @IBOutlet weak var btnOK: UIButton!
    @IBOutlet weak var errorAlert: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("AlertErrorLogin", owner: self, options: nil)
        customAlert()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func customAlert() {
        btnOK.layer.cornerRadius = 15
        
        errorView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        //set lai chieu dai chieu cao cho alert
        errorView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
    
    func showInfor(){
        UIApplication.shared.keyWindow?.addSubview(errorView)
    }
    
    @IBAction func btn_ok(_ sender: Any) {
        errorView.removeFromSuperview()
    }
}
