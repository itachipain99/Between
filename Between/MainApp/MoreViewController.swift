//
//  MoreViewController.swift
//  Between
//
//  Created by Nguyễn Minh Hiếu on 2/15/20.
//  Copyright © 2020 Nguyễn Minh Hiếu. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {

    
    @IBOutlet weak var imgSetting: UIImageView!
    
    @IBOutlet weak var moreTableView: UITableView!{
        didSet{
            self.moreTableView.dataSource = self
            self.moreTableView.delegate = self
        }
    }
    
    var g : CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { (timer) in
            self.g += 45
            UIView.animate(withDuration: 0.3) {
                self.imgSetting.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI)*self.g/180, 0, 0, 1)
            }
        }
    }
    


}

extension MoreViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MoreTableViewCell") as? MoreTableViewCell else{
            return UITableViewCell()
        }
        return cell
    }

}
extension MoreViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
