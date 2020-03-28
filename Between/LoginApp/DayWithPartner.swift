//
//  DayWithPartner.swift
//  Between
//
//  Created by Nguyễn Minh Hiếu on 2/4/20.
//  Copyright © 2020 Nguyễn Minh Hiếu. All rights reserved.
//

import UIKit
import RealmSwift

class DayWithPartner: UIViewController {

    @IBOutlet weak var viewPartner: UIView!
    @IBOutlet weak var btnGoto: UIButton!
    @IBOutlet weak var tfPartner: UITextField!
    @IBOutlet weak var tfFirst: UITextField!
    
    private var datePicker = UIDatePicker()
    private var check = false
    private var dateForm : Date?
    
    private var email : String?
    private var password : String?
    private var name : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        custom()
        datePicker.addTarget(self, action: #selector(settfFirst), for: .valueChanged)
        settfFirst()
        tfFirst.delegate = self
        dbManager = DBManager.shared
    }

    func initData(_ dataEmail : String,_ dataPassword : String ,_ dataName : String){
        self.email = dataEmail
        self.password = dataPassword
        self.name = dataName
    }
    
    
    
    func custom() {
        btnGoto.layer.borderColor = #colorLiteral(red: 0.8861779571, green: 0.8863301873, blue: 0.8861683011, alpha: 1)
        btnGoto.layer.borderWidth = 1
        btnGoto.layer.cornerRadius = 10
        
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
    }
    
    func showDatepicker() {
        datePicker.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width/1.4)
        tfFirst.inputView = datePicker // them vao view datepicker
    }
    
    
    @objc func settfFirst() {
        let date = datePicker.date
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MMM dd,yyyy"
        dateFormat.timeZone = TimeZone(abbreviation: "GMT")
        tfFirst.text = dateFormat.string(from: date)
        dateForm = dateFormat.date(from: dateFormat.string(from: date))
    }
    
    
    @IBAction func goBetWeen(_ sender: Any) {
        
        let object = User()
        dbManager.uppdate(object) { [weak self] in
             object.email = email!
             object.password = password!
             object.name = name!
             object.namePartner = tfPartner.text!
             object.dayBegin = dateForm!
        }
    
        if let vc = sb.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController {
            UserDefaults.standard.set(email,forKey: Keys.keyUserEmail)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension DayWithPartner : UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.showDatepicker()
        return true
    }
}

