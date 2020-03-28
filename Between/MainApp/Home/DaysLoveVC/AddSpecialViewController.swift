//
//  SelectAddSpecialViewController.swift
//  Between
//
//  Created by Nguyễn Minh Hiếu on 2/16/20.
//  Copyright © 2020 Nguyễn Minh Hiếu. All rights reserved.
//

import UIKit

class AddSpecialViewController: UIViewController {

    @IBOutlet weak var addTableView: TableView!{
        didSet{
            self.addTableView.dataSource = self
            self.addTableView.delegate = self
        }
    }
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contantView: UIView!
    @IBOutlet weak var contraintContentHeight: NSLayoutConstraint!
    
    private var isTapDate = false
    var isTapNote = false
    var checkColor = false
    var Checkmark = [7,1,0]
    var lblAdd = ["Select category","Every year",""]
    override func viewDidLoad() {
        super.viewDidLoad()
        addTableView.rowHeight = UITableView.automaticDimension
        addTableView.estimatedRowHeight = 200
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CategoryPrepare" {
            guard let VC = segue.destination as? EditAddViewController else {return}
            VC.isCategory = true
            VC.Checkmark = Checkmark[0]
            VC.closurePassData = {[weak self] in
                self?.Checkmark[0] = $2
                self?.lblAdd[0] = $1
                self?.checkColor = true
                self!.addTableView.reloadData()
            }
        }
        else if segue.identifier == "RepeatPrepare" {
            guard let VC = segue.destination as? EditAddViewController else {return}
            VC.isRepeat = true
            VC.Checkmark = Checkmark[1]
            VC.closurePassData = {[weak self] in
                self?.Checkmark[1] = $2
                self?.lblAdd[1] = $1
                self!.addTableView.reloadData()
            }
        }
        else {
            guard let VC = segue.destination as? EditAddViewController else {return}
            VC.isAlert = true
            VC.Checkmark = Checkmark[2]
            VC.closurePassData = {[weak self] in
                self?.Checkmark[2] = $2
                self?.lblAdd[2] = $1
                self!.addTableView.reloadData()
            }
        }
   }
    
    @IBAction func btn_Close(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func isPan(_ sender: Any) {
        isTapNote = false
        addTableView.isScrollEnabled = true
        addTableView.reloadData()
    }
    
    @IBAction func btn_Done(_ sender: Any) {
        
    }
}

extension AddSpecialViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 2:
            return 3
        default:
            return 1
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1Section0") as? Cell1Section0 else{
                    return UITableViewCell()
                }
                return cell
            default:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2Section0") as? Cell2Section0 else{
                    return UITableViewCell()
                }
                cell.lblCategory.text = lblAdd[0]
                if checkColor{cell.lblCategory.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)}
                return cell
            }
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Section1") as? Section1 else{
                return UITableViewCell()
            }
            return cell
        case 2:
            switch indexPath.row {
            case 0:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1Section2") as? Cell1Section2 else{
                    return UITableViewCell()
                }
                return cell
            case 1:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2Section2") as? Cell2Section2 else{
                    return UITableViewCell()
                }
                
                return cell
            default:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell3Section2") as? Cell3Section2 else{
                    return UITableViewCell()
                }
                cell.lblRepeat.text = lblAdd[1]
                return cell
            }
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Section3") as? Section3 else{
                return UITableViewCell()
            }
            cell.lblAlert.text = lblAdd[2]
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Section4") as? Section4 else{
                return UITableViewCell()
            }
            cell.parentVC = self
            return cell
        }
    }
}
extension AddSpecialViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.view.endEditing(true)
        if indexPath.section == 2 && indexPath.row == 0 {
            if !isTapDate{isTapDate = true}
            else {isTapDate = false}
            tableView.beginUpdates()
            tableView.endUpdates()
        }
        if indexPath.section == 4{
            if !isTapNote {isTapNote = true}
            tableView.isScrollEnabled = false
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if !isTapNote {
            return 20
        }
        else{
            if section == 4 {return 400}
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if !isTapNote {
            if isTapDate && indexPath.section == 2 && indexPath.row == 0{return 230}
            else if !isTapDate && indexPath.section == 2 && indexPath.row == 0 {return 44}
            else if indexPath.section == 4 {return 250}
            else {return 44}
        }
        else{
            if indexPath.section == 4 {return 250}
            else {return 0}
        }
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
   //     tableView.ins
    }
}

