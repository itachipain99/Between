//
//  HomeViewController.swift
//  Between
//
//  Created by Nguyễn Minh Hiếu on 2/15/20.
//  Copyright © 2020 Nguyễn Minh Hiếu. All rights reserved.
//

import UIKit
import Photos
import RealmSwift

let sbHome = UIStoryboard(name: "Home", bundle: nil)

class HomeViewController: UIViewController {
    // bien
    var result : User?
    var resultPartner : Partner?
    var resultYourself : YourSelf?
    var days = 0
    var checkImage = false
    
 //   weak var DataP : Delegate?

    @IBOutlet weak var imgBackGround: UIImageView!
    @IBOutlet weak var imgPerson1: UIImageView!
    @IBOutlet weak var imgPerson2: UIImageView!
    @IBOutlet weak var lblDaysLove: UILabel!
    @IBOutlet weak var lblPersonLove: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Begin()
        daysLove()
        lblDaysLove.text = "\(days) days since"
        lblPersonLove.text = "\(result!.namePartner!) ❤️ \(result!.name!)"
        ProfilePerson1.pf.parentVC = self
    }

    
    func Begin(){
        let key = UserDefaults.standard.value(forKey: Keys.keyUserEmail)
        result = dbManager.search(User.self,filter: key as! String,key:"email").first as? User
        resultPartner = dbManager.search(Partner.self,filter: key as! String,key:"key").first as? Partner
        resultYourself = dbManager.search(YourSelf.self,filter: key as! String,key:"key").first as? YourSelf
        // set img
        if let imgP = resultPartner?.photoPathner{
            imgPerson1.image = UIImage(data: imgP)
        }
        if let imgY = resultYourself?.photoYourself{
            imgPerson2.image = UIImage(data: imgY)
        }
    }
    // reckon days
    func daysLove(){
        let daynow = Date()
        days = Calendar.current.dateComponents([.day], from: result!.dayBegin!, to: daynow).day!
    }

    @IBAction func btn_Person1(_ sender: Any) {
        checkImage = true
        ProfilePerson1.pf.showInfor(result!.namePartner!)
    }
    
    @IBAction func btn_Person2(_ sender: Any) {
        checkImage = false
        ProfilePerson1.pf.showInforYourself(result!.name!)
    }
    // navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SpecialDay" as? String  {
            if let navigationVC = segue.destination as? UINavigationController,let vc = navigationVC.viewControllers.first as? SpecialDaysViewController {
                // push data to Special day
                vc.pushData(result!.name!, result!.namePartner!,result!.dayBegin!,days)
                let imgP = resultPartner?.photoPathner
                let imgY = resultYourself?.photoYourself
                if imgY == nil && imgP != nil {
                     vc.pushDataImg(imgP!,Data())
                }
                else if imgP == nil && imgY != nil {
                    vc.pushDataImg(Data(),imgY!)
                }
                else if imgP != nil && imgY != nil{
                    vc.pushDataImg(imgP!,imgY!)
                }
                else{
                    vc.pushDataImg(Data(),Data())
                }
                
            }
        }
    }
}

//protocol Delegate : class{
//    func pushData(_ name : String,_ namePartner : String,_ dayBegin : Date,_ daysLove : Int)
//    func pushDataImg(_ imgPartner : Data,_ imgYourself : Data)
//}
