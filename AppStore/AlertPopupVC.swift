//
//  AlertPopupVC.swift
//  AppStore
//
//  Created by Faiz Sharief on 16/10/18.
//  Copyright © 2018 . All rights reserved.
//

import UIKit

class AlertPopupVC: UITableViewController {

    @IBAction func cancel(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
