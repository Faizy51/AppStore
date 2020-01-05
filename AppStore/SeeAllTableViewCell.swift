//
//  SeeAllTableViewCell.swift
//  AppStore

import UIKit

class SeeAllTableViewCell: UITableViewCell {
    
    @IBOutlet weak var appIcon: UIImageView!
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var appDesc: UILabel!
    var ins = TableViewCellTwo()
    
    // Show Alert Popup for app download.
    @IBAction func getButton( sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AlertViewController")
        vc.modalPresentationStyle = .overCurrentContext
        (self.window?.rootViewController)?.present(vc, animated: true, completion: nil)
    }


}
