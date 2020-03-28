//
//  ProfilePerson1.swift
//  Between
//
//  Created by Nguyễn Minh Hiếu on 2/13/20.
//  Copyright © 2020 Nguyễn Minh Hiếu. All rights reserved.
//

import UIKit
import Photos
import RealmSwift

class ProfilePerson1 : UIView {
    
    static let pf = ProfilePerson1()
    
    weak var parentVC : HomeViewController?
    
    private var img1 : UIImage = UIImage(systemName: "person.circle.fill")!
    private var img2 : UIImage = UIImage(systemName: "person.circle.fill")!
    
    @IBOutlet var Profile: UIView!
    @IBOutlet weak var viewProfile: UIView!
    @IBOutlet weak var viewPhone: UIView!
    @IBOutlet weak var imgCover: UIImageView!
    @IBOutlet weak var imgPerson: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblBirthday: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblCall: UILabel!
    @IBOutlet weak var btnEdit: UIButton!
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("ProfilePerson1", owner: self, options: nil)
        customForm()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customForm(){
        Profile.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        Profile.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
    
    func showInfor(_ name : String){
        if let img = parentVC!.resultPartner!.photoPathner {
            img1 = UIImage(data: img)!
        }
        imgPerson.image = img1
        print(name)
        lblName.text = name
        UIApplication.shared.keyWindow?.addSubview(Profile)
    }
    
    func showInforYourself(_ name : String){
        if let img = parentVC!.resultYourself!.photoYourself {
            img2 = UIImage(data: img)!
        }
        imgPerson.image = img2
        lblName.text = name
        btnEdit.setTitle("Edit Infor", for: .normal)
        lblCall.isHidden = true
        viewPhone.isHidden = true
        UIApplication.shared.keyWindow?.addSubview(Profile)
    }
    @IBAction func btn_x(_ sender: Any) {
        Profile.removeFromSuperview()
    }
    // so library
    @IBAction func btn_ImgPs(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable( .photoLibrary){
            PHPhotoLibrary.requestAuthorization { (status) in
                switch status {
                case .authorized :
                    DispatchQueue.main.async {
                          let pickerController = UIImagePickerController()
                          pickerController.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
                          pickerController.sourceType = .photoLibrary
                          self.parentVC!.present(pickerController, animated: true, completion: nil)
                    }
                @unknown default:
                    break
                }
            }
        }
        
    }
    
    @IBAction func btn_call(_ sender: Any) {
        
    }
    
    @IBAction func btn_ChangeNumber(_ sender: Any) {
        
    }
}

extension ProfilePerson1 : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            // partner
            if parentVC!.checkImage {
                parentVC?.imgPerson1.image = image
                self.imgPerson.image = image
                self.img1 = image
                let data : Data = img1.jpegData(compressionQuality: 1.0)!
                let partner = Partner()
                dbManager.uppdate(partner, update: {[weak self] in
                    partner.key = UserDefaults.standard.value(forKey: Keys.keyUserEmail) as! String
                    partner.photoPathner = data
                })
            }
            // yourself
            else {
                parentVC?.imgPerson2.image = image
                self.imgPerson.image = image
                self.img2 = image
                let data : Data = img2.jpegData(compressionQuality: 1.0)!
                let yourself = YourSelf()
                dbManager.uppdate(yourself, update: {[weak self] in
                    yourself.key = UserDefaults.standard.value(forKey: Keys.keyUserEmail) as! String
                    yourself.photoYourself = data
                })
            }
        }
        parentVC?.dismiss(animated: true, completion: nil)
    }
}
