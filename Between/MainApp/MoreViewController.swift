//
//  MoreViewController.swift
//  Between
//
//  Created by Nguyễn Minh Hiếu on 2/15/20.
//  Copyright © 2020 Nguyễn Minh Hiếu. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {

    @IBOutlet weak var moreTableView: UITableView!{
        didSet{
            self.moreTableView.dataSource = self
            self.moreTableView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
