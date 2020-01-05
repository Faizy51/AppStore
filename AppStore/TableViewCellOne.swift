//
//  TableViewCellOne.swift
//  AppStore
//
//  Created by Faiz Sharief on 03/10/18.
//  Copyright © 2018 . All rights reserved.
//

import UIKit

class TableViewCellOne: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var bigCollectionView: UICollectionView!

    var dummyImages = ["one","two","three"]
    var dummyNames = ["PUBG","Fortnite","Pokemon"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        bigCollectionView.delegate = self
        bigCollectionView.dataSource = self
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummyImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bigCollectionView.dequeueReusableCell(withReuseIdentifier: "coll1", for: indexPath) as! CollectionViewCellOne
        cell.image.image = UIImage(named: dummyImages[indexPath.row])
        cell.image.layer.cornerRadius = 10
        cell.appName.text = dummyNames[indexPath.row]
        cell.appCategory.text = "Play Once, Play always"
        return cell
    }
}
