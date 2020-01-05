//
//  CollectionViewCellTwo.swift
//  AppStore
//
//  Created by Faiz Sharief on 03/10/18.
//  Copyright © 2018 . All rights reserved.
//

import UIKit

class CollectionViewCellTwo: UICollectionViewCell,UITableViewDataSource, UITableViewDelegate{
    
    var appDel = UIApplication.shared.delegate as! AppDelegate
    var appData : [Application] = []
    var ip : IndexPath?
    var tableData : CollectionCellModel?
    
    @IBOutlet weak var innerTable: UITableView!
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (tableData?.applications?.count)!
    }
    
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let innerCell = innerTable.dequeueReusableCell(withIdentifier: "incell1") as! InnerTableViewCell
        if (tableData?.applications?.count) != nil{
            innerCell.appName.text = tableData?.applications![indexPath.row].trackCensoredName
            innerCell.appDescription.text = tableData?.applications![indexPath.row].description
            innerCell.selectionStyle = .none
            innerCell.appIcon.imageFromURL(urlString: (tableData?.applications![indexPath.row].artworkUrl100!)!)
        }
        return innerCell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    

}
