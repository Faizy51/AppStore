//
//  UpdatesViewController.swift
//  AppStore
//
//  Created by Faiz Sharief on 03/10/18.
//  Copyright © 2018 . All rights reserved.
//

import UIKit

class UpdatesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var updatesTable: UITableView!
    var appDel = UIApplication.shared.delegate as! AppDelegate
    var buttonLabels :[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 0...5 {
            buttonLabels.append("UPDATE")
        }

        updatesTable.estimatedRowHeight = 200
        
        // Set datasource and delegates.
        updatesTable.delegate = self
        updatesTable.dataSource = self
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as! UpdatesTableViewCell
        var array : [Application] = []
        
        // Updates section
        if indexPath.section == 0{
            for i in 0...5 {
                array.append(appDel.allDownloadedApps[i])
            }
            cell.btnOutlet.setTitle(buttonLabels[indexPath.row], for: .normal)
        }
            
        // Section having recently updated applications.
        else{
            for i in 6...11 {
                array.append(appDel.allDownloadedApps[i])
            }
            cell.btnOutlet.setTitle("OPEN", for: .normal)
        }
        cell.iconImage.imageFromURL(urlString: array[indexPath.row].artworkUrl100!)
        cell.name.text = array[indexPath.row].trackCensoredName
        cell.appDescription.text = array[indexPath.row].description
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.white
        let label = UILabel(frame: CGRect(x: 20, y: 10, width: 200, height: 20))
        label.font = UIFont.boldSystemFont(ofSize: 17.0)
        
        // Add a button - "Update All" only for the first section
        if section == 0{
            let button = UIButton(frame: CGRect(x: tableView.frame.size.width-110, y: 10, width: 100, height: 20))
            button.setTitle("Update All", for: .normal)
            button.setTitleColor(UIColor.blue, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
            button.addTarget(self, action: #selector(printerFunc), for: .touchUpInside)
            view.addSubview(button)
            label.text = "Pending"
        }
        // Second section
        else{
            label.text = "Recently updated"
        }
        
        view.addSubview(label)
        return view
    }
    @objc func printerFunc(){
        sleep(1)
        
        // Updates completed, Change the badge value.
        let badge = (self.parent?.parent as! UITabBarController).tabBar.items![2].badgeValue
        if badge != nil{
            (self.parent?.parent as! UITabBarController).tabBar.items![2].badgeValue = nil
        }
        // Change all apps button labels as "OPEN"
        for i in 0..<buttonLabels.count{
            buttonLabels[i] = "OPEN"
            updatesTable.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
}
