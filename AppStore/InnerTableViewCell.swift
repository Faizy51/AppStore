//
//  InnerTableViewCell.swift
//  AppStore
//
//  Created by Faiz Sharief on 03/10/18.
//  Copyright © 2018 . All rights reserved.
//


import UIKit

class InnerTableViewCell: UITableViewCell {

    @IBOutlet weak var actIndicator: UIActivityIndicatorView!
    @IBOutlet weak var appIcon: UIImageView!
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var appDescription: UILabel!
    
    @IBAction func install(_ sender: Any) {
        // Implement activity indicator and an alert sheet here
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AlertViewController")
        vc.modalPresentationStyle = .overCurrentContext
        (self.window?.rootViewController)?.present(vc, animated: true, completion: nil)
    }

}
