//
//  ViewController.swift
//  Between
//
//  Created by Nguyễn Minh Hiếu on 1/30/20.
//  Copyright © 2020 Nguyễn Minh Hiếu. All rights reserved.
//

import UIKit
import RealmSwift
import KeychainSwift

let colorApp = #colorLiteral(red: 0.1052509025, green: 0.8059832454, blue: 0.7713117003, alpha: 1)
var dbManager : DBManager!

struct Keys {
    static let keyChainPrefix = "prefix_"
    static let keyChainEmail = "User_"
    static let keyChainPassword = "Password_"
    static let checkRemember = "remember_"
    static let keyUserEmail = "EmailS"
}

let sb = UIStoryboard(name: "Main", bundle: nil)
class ViewController: UIViewController {

    @IBOutlet weak var view1: CustomUIView!
    @IBOutlet weak var viewSelect: UIView!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var tfSelect: UITextField!
    @IBOutlet weak var viewCircleLoad: SetupbgButton!
    @IBOutlet weak var lblLogin: UILabel!
    
    var checkbtnSelect = false
    
    private var dataUser : Results<User>!
    private var keychain = KeychainSwift(keyPrefix: Keys.keyChainPrefix)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customViewLogin()
        tfEmail.addTarget(self, action: #selector(targetEmail), for: .editingChanged)
        tfPassword.addTarget(self, action: #selector(targetEmail), for: .editingChanged)
        
        if (UserDefaults.standard.value(forKey: Keys.checkRemember) != nil) {
            guard let emailData = keychain.get(Keys.keyChainEmail), let passwordData = keychain.get(Keys.keyChainPassword) else {return }
              tfEmail.text! = emailData
              tfPassword.text! = passwordData
              self.targetEmail()
        }
        dbManager = DBManager.shared
        dataUser = dbManager.getData()
    }
    
    @objc func targetEmail() {
        var checkEmail = tfEmail.hasText
        var checkPassword = tfPassword.hasText
        if checkEmail && checkPassword {
            btnLogin.isUserInteractionEnabled = true
            lblLogin.textColor = colorApp
        }
        else{
            btnLogin.isUserInteractionEnabled = false
            lblLogin.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        }
    }
    
    
    func customViewLogin() {
        lblLogin.layer.cornerRadius = 10
        btnSelect.layer.cornerRadius = 5
        viewCircleLoad.layer.cornerRadius = 10
    }
    
    @IBAction func btn_Login(_ sender: Any) {
        if checkbtnSelect {
            guard let txtEmail = tfEmail.text,let txtPassword = tfPassword.text else { return }
            if keychain.set(txtEmail, forKey: Keys.keyChainEmail) && keychain.set(txtPassword, forKey: Keys.keyChainPassword){
                print("oke")
            }
        }
        let result = dbManager.search(User.self,filter: tfEmail.text!,key: "email").first as? User
        if result == nil || result!.password != tfPassword.text! {
            AlertErrorLogin.alert.showInfor()
        }
        else{
            lblLogin.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            lblLogin.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            viewCircleLoad.startAnimating()
            if let vc = sb.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController{
                UserDefaults.standard.set(tfEmail.text!, forKey: Keys.keyUserEmail)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @IBAction func btn_Select(_ sender: Any) {
        switch checkbtnSelect {
        case false:
            UserDefaults.standard.set(true, forKey: Keys.checkRemember)
            checkbtnSelect = true
            viewSelect.backgroundColor = colorApp
            tfSelect.backgroundColor = colorApp
        default:
            checkbtnSelect = false
            viewSelect.backgroundColor = #colorLiteral(red: 0.9802859426, green: 0.9804533124, blue: 0.9802753329, alpha: 1)
            tfSelect.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    
    @IBAction func btn_tapBigView(_ sender: Any) {
        viewSelect.backgroundColor = #colorLiteral(red: 0.9802859426, green: 0.9804533124, blue: 0.9802753329, alpha: 1)
        self.view.endEditing(true)
    }
    
}


//
//    func customForm(){
//        tfemail = UITextField(frame: CGRect(x: BoundScreen.width*0.15, y: BoundScreen.height*0.2, width: BoundScreen.width*0.7, height: BoundScreen.height*0.07))
//        tfemail.borderStyle = .roundedRect
//        tfemail.placeholder = "Email"
//        tfemail.textColor = UIColor.black
//        view.addSubview(tfemail)
//
//        tfpasword = UITextField(frame: CGRect(x: BoundScreen.width*0.15, y: BoundScreen.height*0.29, width: BoundScreen.width*0.7, height: BoundScreen.height*0.07))
//        tfpasword.borderStyle = .roundedRect
//        tfpasword.placeholder = "Password"
//        tfpasword.textColor = UIColor.black
//        view.addSubview(tfpasword)
//
//        btnlogin = UIButton(frame: CGRect(x: BoundScreen.width*0.15, y: BoundScreen.height*0.4, width: BoundScreen.width*0.7, height: BoundScreen.height*0.07))
//        btnlogin.isEnabled = true
//        btnlogin.backgroundColor = .lightGray
//        btnlogin.layer.cornerRadius = 5
//        btnlogin.clipsToBounds = true
//        btnlogin.isSelected = true
//        btnlogin.setTitleColor(.black, for: .normal)
//        btnlogin.setTitle("Login", for: .normal)
//
//        view.addSubview(btnlogin)
//
//    }
