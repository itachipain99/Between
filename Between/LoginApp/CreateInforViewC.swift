//
//  CreateInforViewC.swift
//  Between
//
//  Created by Nguyễn Minh Hiếu on 2/4/20.
//  Copyright © 2020 Nguyễn Minh Hiếu. All rights reserved.
//

import UIKit
import RealmSwift

class CreateInforViewC: UIViewController {

    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var lightCheckEmail: UIView!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var lightCheckName: UIView!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var lightCheckPassword: UIView!
    @IBOutlet weak var tfConfirm: UITextField!
    @IBOutlet weak var lightCheckConfirm: UIView!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var loadingSignUp: SetupbgButton!
    @IBOutlet weak var viewScroll: UIView!
    @IBOutlet weak var heightViewScroll: NSLayoutConstraint!
    @IBOutlet weak var scrollview: UIScrollView!

    //chieu cao cua tf
    private var activeTView : UITextField?
    //vi tri cua tf
    private var lastOffset : CGPoint?
    //chieu cao cua keyboard
    private var keyboardHeight  : CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customCreate()
        tfEmail.addTarget(self, action: #selector(targetbtn), for: .editingChanged)
        tfName.addTarget(self, action: #selector(targetbtn), for: .editingChanged)
        tfPassword.addTarget(self, action: #selector(targetbtn), for: .editingChanged)
        tfConfirm.addTarget(self, action: #selector(targetbtn), for: .editingChanged)
        
        tfEmail.delegate = self
        tfName.delegate = self
        tfPassword.delegate = self
        tfConfirm.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self
            , selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    
 //       print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: self)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: self)
    }
    
    func checkTf (_ tf: UITextField,_ ui : UIView){
        switch tf.hasText {
        case true:
            ui.backgroundColor = #colorLiteral(red: 0.1012684032, green: 0.6359764338, blue: 0.3756580353, alpha: 1)
        default:
            ui.backgroundColor = #colorLiteral(red: 0.8715731502, green: 0.3214607239, blue: 0.2723865211, alpha: 1)
        }
    }

    @objc func targetbtn() {
        var resultEmail = dbManager.search(User.self,filter: tfEmail.text!,key: "email").first as? User
        var checkok = false
        var checkConfirm = false
        if tfEmail.hasText && resultEmail == nil {
            checkok = true
            lightCheckEmail.backgroundColor = #colorLiteral(red: 0.1012684032, green: 0.6359764338, blue: 0.3756580353, alpha: 1)
        }
        else {
            lightCheckEmail.backgroundColor = #colorLiteral(red: 0.8715731502, green: 0.3214607239, blue: 0.2723865211, alpha: 1)
        }
        self.checkTf(tfName, lightCheckName)
        self.checkTf(tfPassword, lightCheckPassword)
        if tfConfirm.text == tfPassword.text && tfPassword.hasText{
            checkConfirm = true
            lightCheckConfirm.backgroundColor = #colorLiteral(red: 0.1012684032, green: 0.6359764338, blue: 0.3756580353, alpha: 1)
        }
        else{
            lightCheckConfirm.backgroundColor = #colorLiteral(red: 0.8715731502, green: 0.3214607239, blue: 0.2723865211, alpha: 1)
        }
        if tfEmail.hasText && tfName.hasText && tfPassword.hasText && tfConfirm.hasText && checkConfirm && checkok{
            btnSignUp.isUserInteractionEnabled = true
            btnSignUp.setTitleColor(colorApp, for: .normal)
        }
        else{
            btnSignUp.isUserInteractionEnabled = false
            btnSignUp.setTitleColor(#colorLiteral(red: 0.6744349003, green: 0.6745528579, blue: 0.6744274497, alpha: 1), for: .normal)
        }
    }
    
    func customCreate() {
        btnSignUp.layer.cornerRadius = 10
    }
    
    @IBAction func btn_SignUP(_ sender: Any) {
        btnSignUp.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        btnSignUp.setTitleColor(#colorLiteral(red: 0.6744349003, green: 0.6745528579, blue: 0.6744274497, alpha: 0), for: .normal)
        loadingSignUp.startAnimating()
    }

    
    @IBAction func btn_SignUp(_ sender: Any) {
        if let vc = sb.instantiateViewController(withIdentifier: "DayWithPartner") as? DayWithPartner{
            vc.initData(tfEmail.text!, tfPassword.text!, tfName.text!)
            let object = User()
            dbManager.add(object) {[weak self] in
                object.email = tfEmail.text!
                object.password = tfPassword.text!
                object.name = tfName.text!
            }
            let partner = Partner()
            dbManager.add(partner) {[weak self] in
                partner.key = tfEmail.text!
            }
            let yourself = YourSelf()
            dbManager.add(yourself) {[weak self] in
                yourself.key = tfEmail.text!
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
        self.view.endEditing(true)
    }
    
    @IBAction func signin(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func bigTap(_ sender: Any) {
        self.view.endEditing(true)
    }
    @objc func keyboardWillShow(notification : NSNotification){
        if keyboardHeight != nil {
            return
        }
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            keyboardHeight = keyboardSize.height
        }
        // set lai kich thuoc cua uiview chua tf
        UIView.animate(withDuration: 1, animations: {
            self.heightViewScroll.constant -= self.keyboardHeight! 
        })
        if activeTView != nil{
            //xac dinh diem duoi cua tf = heightScroll - vi tri cua tf - height tf
            let distanceBottom = self.scrollview.bounds.height - (activeTView?.frame.origin.y)! - (activeTView?.bounds.height)!
            //khoang cach cua diem duoi so voi key = chieu co cua keyboard - diem duoi
            let collapseSpace = keyboardHeight! - distanceBottom
            //neu no < 0 thi return
            if collapseSpace < 0 {
                return
            }
            //xet lai vi tri cho Scroll =  khaong cach duoi + 10
//            UIView.animate(withDuration: 1) {
//                print(1)
//               self.scrollview.contentOffset = CGPoint(x: self.lastOffset!.x, y: collapseSpace - 10 )
//            }
        }
     }

     @objc func keyboardWillHide(notification : NSNotification){
           UIView.animate(withDuration: 0.3, animations: {
           guard let keyboardHeight = self.keyboardHeight, let lastOffset = self.lastOffset else{
               return
           }
           self.heightViewScroll.constant += keyboardHeight
           self.scrollview.contentOffset = lastOffset 
       })
       keyboardHeight = nil
     }
    
}



extension CreateInforViewC : UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        activeTView = textField
        lastOffset = scrollview.contentOffset
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        activeTView?.resignFirstResponder()
        activeTView = nil
        return true
    }
 
}

