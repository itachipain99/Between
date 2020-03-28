//
//  EditAddViewController.swift
//  Between
//
//  Created by Nguyễn Minh Hiếu on 3/19/20.
//  Copyright © 2020 Nguyễn Minh Hiếu. All rights reserved.
//

import UIKit

class EditAddViewController: UIViewController {

    @IBOutlet weak var lblTitle: UIButton!
    @IBOutlet weak var extenTableView: TableView! {
        didSet{
            self.extenTableView.dataSource = self
            self.extenTableView.delegate = self
        }
    }
    
    var closurePassData : ((_ img : String,_ category : String,_ checkmark : Int) ->())?
//    var closureRepeat : ((_ repeat : String,_ checkmark : Int) -> ())?
//    var closureAlert : ((_ alert : String,_ checkmark : Int) -> ())?
    
    @IBOutlet weak var heightUIView: NSLayoutConstraint!
    var heightSafeArea = UIApplication.shared.statusBarFrame.height
    var heightScren = UIScreen.main.bounds.height
    
    private let Category = ["My birthday","Partner's birthday","Our first day","First kiss","Engagement","Wedding day","Expecting a baby","Other"]
    private let Repeat = ["Never","Every Year"]
    private let Alert = ["None","On day of event (9AM)","1 day before (9AM)","2 days before (9AM)","1 week before (9AM)","10 days before (9AM)","2 weeks before (9AM)"]
    
    var isCategory = false
    var isRepeat = false
    var isAlert = false
    var Checkmark = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(isCategory,isRepeat,isAlert)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        extenTableView.contentSizeDidChange = {
            print($0.height)
            self.heightUIView.constant = $0.height
        }
    }
}

extension EditAddViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isCategory{return Category.count}
        else if isRepeat{return Repeat.count}
        else {return Alert.count}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isCategory {
            lblTitle.setTitle("Category", for: .normal)
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellCategory") as? CellCategory else {
                return UITableViewCell()
            }
            if indexPath.row == Checkmark {
             //   print(Checkmark)
              //  cell.accessoryType = .checkmark
                cell.imgCheckmark.isHidden = false
            }
            cell.lblCategory.text = Category[indexPath.row]
            return cell
        }
        else if isRepeat{
            lblTitle.setTitle("Repeat", for: .normal)
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellRepeat") as? CellRepeat else {
                return UITableViewCell()
            }
            if indexPath.row == Checkmark {
                cell.imgCheckmark.isHidden = false
               // cell.accessoryType = .checkmark
            }
            cell.lblRepeat.text = Repeat[indexPath.row]
            return cell
        }
        else{
            lblTitle.setTitle("Alert", for: .normal)
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellAlert") as? CellAlert else {
                return UITableViewCell()
            }
            if indexPath.row == Checkmark {
                cell.imgCheckmark.isHidden = false
               // cell.accessoryType = .checkmark
            }
            cell.lblAlert.text = Alert[indexPath.row]
            return cell
        }
    }
}

extension EditAddViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if isCategory {return heightScren - heightSafeArea - CGFloat(Category.count*44 + 60)}
        else if isRepeat{return heightScren - heightSafeArea - CGFloat(Repeat.count*44 + 60)}
        else{return heightScren - heightSafeArea - CGFloat(Alert.count*44 + 60)}
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var imgCategory : String?
        var lbl : String?
        if isCategory {lbl = Category[indexPath.row]}
        else if isRepeat{lbl = Repeat[indexPath.row]}
        else {lbl = Alert[indexPath.row]}
        self.Checkmark = indexPath.row
        self.closurePassData?("",lbl!,Checkmark)
        self.navigationController?.popViewController(animated: true)
    }
}
