//
//  MoreTableViewCell.swift
//  Between
//
//  Created by Nguyễn Minh Hiếu on 2/17/20.
//  Copyright © 2020 Nguyễn Minh Hiếu. All rights reserved.
//

import UIKit

class MoreTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            self.collectionView.dataSource = self
        }
    }
    
    private let Sticker = ["","","","",""]
    private let StickerName = ["Sticker Store","Themes","Between Plus","Tell friends","Support"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        custom()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func custom() {
        let layout = UICollectionViewFlowLayout() // bố cục của collection view
        layout.minimumInteritemSpacing = 0 //  khoảng cách giữa 2 hàng
        layout.minimumLineSpacing = 0  // khoảng cách giữa 2 cột'
        layout.scrollDirection = .vertical // tay đổi hướng của scroll
        layout.itemSize = CGSize(width:self.bounds.width/4, height:self.bounds.height/2) // can chinh size của item
        collectionView.collectionViewLayout = layout // gắn các thuộc tính của layout vào collection view
        collectionView.sizeToFit()
        collectionView.showsHorizontalScrollIndicator = false // co show srcoll k
        collectionView.isPagingEnabled = true // lật trang
        collectionView.bounces = true // hiệu ứng
        collectionView.reloadData()
    }
}

extension MoreTableViewCell : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Sticker.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoreCollectionViewCell", for: indexPath) as? MoreCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.lblSticker.text = StickerName[indexPath.row]
        return cell
    }
    
    
}
