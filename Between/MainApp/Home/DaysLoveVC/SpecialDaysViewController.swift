//
//  IMGBackGroundViewController.swift
//  Between
//
//  Created by Nguyễn Minh Hiếu on 2/15/20.
//  Copyright © 2020 Nguyễn Minh Hiếu. All rights reserved.
//

import UIKit

class SpecialDaysViewController: UIViewController {
    
    
    @IBOutlet weak var bigTableView: TableView!{
        didSet{
            self.bigTableView.dataSource = self
            self.bigTableView.delegate = self
            self.bigTableView.register(UINib(nibName: "AddTableViewCell", bundle: nil), forCellReuseIdentifier: "AddTableViewCell")
            self.bigTableView.register(UINib(nibName: "SpecialDaysTableViewCell", bundle: nil), forCellReuseIdentifier: "SpecialDaysTableViewCell")
            self.bigTableView.register(UINib(nibName: "YearsTableViewCell", bundle: nil), forCellReuseIdentifier: "YearsTableViewCell")
            self.bigTableView.register(UINib(nibName: "ViewHeaderY", bundle: nil), forCellReuseIdentifier: "ViewHeaderY")
            self.bigTableView.register(UINib(nibName: "ViewHeaderSD", bundle: nil), forHeaderFooterViewReuseIdentifier: "ViewHeaderSD")
            self.bigTableView.reloadData()
            
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!

    var heightTableView : CGFloat?
    var heightSafeArea = UIApplication.shared.statusBarFrame.height
    
    var SpecialDays = ["Our first day","Cu Hanh's Birthday","Hieu's Birthday"]
    var Years = ["1 year","2 years","3 years","4 years"]
    var dayLeftYear : Array<Int> = []
    var dateYear : Array<String> = []
    var dayLeftSpecial : Array<Int> = []
    var dateSpecial : Array<String> = []
    // bien push data from home
    var name : String?
    var namePartner : String?
    var dayBegin : Date?
    var daysLove : Int?
    var imgPartner : Data?
    var imgYourself : Data?
    private var isDebugLayout = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        heightTableView = CGFloat(height()) + heightSafeArea
//        bigTableView.rowHeight = UITableView.automaticDimension
//        bigTableView.estimatedRowHeight = 50
        bigTableView.isScrollEnabled = false
        setDataSection2()
    }
    
    func height() -> Int {
        return 300 + Years.count*50 + SpecialDays.count*50
    }
    
    // set layout
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        bigTableView.contentSizeDidChange = {
            if !self.isDebugLayout  {
                self.isDebugLayout = true
                print($0.height)
                self.viewHeight.constant = self.heightTableView!
            }
        }
    }
    
    func setDataSection2(){
        for i in 1...4{
            var calculatedDate = Calendar.current.date(byAdding: .year, value: i, to: dayBegin!, wrappingComponents: false)
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "MMM dd,yyyy"
            let dateForm = dateFormat.string(from: calculatedDate!)
            let daynow = Date()
            var days = Calendar.current.dateComponents([.day], from: daynow , to: calculatedDate!).day!
            dayLeftYear.append(days)
            dateYear.append(dateForm)
            dayLeftSpecial.append(daysLove!)
            dateSpecial.append(dateFormat.string(from: dayBegin!))
        }
    }
    
    @IBAction func btn_Close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func navigationVC(){
        let sp = sbHome.instantiateViewController(withIdentifier: "AddSpecialViewController") as? AddSpecialViewController
        self.navigationController?.pushViewController(sp!, animated: true)
    }
    
    
    // push data form Home
    func pushDataImg(_ imgPartner: Data, _ imgYourself: Data) {
        self.imgPartner =  imgPartner
        self.imgYourself = imgYourself
    }
    func pushData(_ name: String, _ namePartner: String, _ dayBegin: Date, _ daysLove: Int) {
        self.name = name
        self.namePartner = namePartner
        self.dayBegin = dayBegin
        self.daysLove = daysLove
    }
}

extension SpecialDaysViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return Years.count
        default:
            return SpecialDays.count + 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var i = SpecialDays.count
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ViewHeaderY") as? ViewHeaderY else{
                return UITableViewCell()
            }
            if imgPartner! != Data(capacity: 0) {
                cell.imgPerson1.image = UIImage(data: imgPartner!)
            }
            if imgYourself! != Data(capacity: 0) {
                cell.imgPerson2.image = UIImage(data: imgYourself!)
            }
            let date = dayBegin
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "MMM dd,yyyy"
            cell.lblDate.text = dateFormat.string(from: date!)
            cell.lblDays.text = "\(daysLove!) days since"
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "YearsTableViewCell") as? YearsTableViewCell else{
                return UITableViewCell()
            }
            cell.lblYears.text = Years[indexPath.row]
            cell.lblDaysLeft.text = "\(dayLeftYear[indexPath.row]) days left"
            cell.lblDayLeftCalendar.text = dateYear[indexPath.row]
            return cell
        default:
            switch indexPath.row {
            case 0:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddTableViewCell",for: indexPath) as? AddTableViewCell else{
                    return UITableViewCell()
                }
                return cell
            default:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "SpecialDaysTableViewCell",for: indexPath) as? SpecialDaysTableViewCell else{
                    return UITableViewCell()
                }
                cell.lblSpecial.text = SpecialDays[i - indexPath.row]
                i -= 1
                if indexPath.row == SpecialDays.count {
                    cell.lblDaysLeft.text = "\(dayLeftSpecial[0]) days since"
                    cell.lblCalendarDays.text = dateSpecial[0]
                }
                return cell
            }
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 2{
            guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ViewHeaderSD") as? ViewHeaderSD else {
                return UITableViewHeaderFooterView()
            }
            return view
        }
        else{
            return UITableViewHeaderFooterView()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
}

extension SpecialDaysViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 2 {return 44}
        else {return 0}
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {return 10}
        else {return 0}
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 2 && indexPath.row == 0{
            self.navigationVC()
        }
    }
}


