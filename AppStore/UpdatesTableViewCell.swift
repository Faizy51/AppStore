//
//  UpdatesTableViewCell.swift
//  AppStore
//
//  Created by Faiz Sharief on 17/10/18.
//  Copyright © 2018 . All rights reserved.
//

import UIKit

class UpdatesTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var appDescription: UILabel!
    
    @IBOutlet weak var btnOutlet: UIButton!
    @IBAction func openButton(_ sender: UIButton) {

        if sender.titleLabel?.text == "UPDATE"{
            let parent = (((self.window?.rootViewController as! UITabBarController).children[2] as! UINavigationController).viewControllers[0] as! UpdatesViewController)
            let ip = parent.updatesTable.indexPath(for: self)
            parent.buttonLabels[(ip?.row)!] = "OPEN"
            (self.window?.rootViewController as! UITabBarController).tabBar.items![2].badgeValue = "\(Int((self.window?.rootViewController as! UITabBarController).tabBar.items![2].badgeValue!)! - 1)"
            parent.updatesTable.reloadData()
        }
    }
}
