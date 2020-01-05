//
//  SeeAllViewController.swift
//  AppStore
//
//  Created by Faiz Sharief on 04/10/18.
//  Copyright © 2018 . All rights reserved.
//

import UIKit

protocol SeeAllDelegate {
    var allApps: [Application] {get set}
}

class SeeAllViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SeeAllDelegate {
    
    var allApps: [Application] = []

    @IBOutlet weak var seeAllTable: UITableView!
    let appDel = UIApplication.shared.delegate as! AppDelegate
    let collectionCellInstance = CollectionViewCellTwo()
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let src = sender as! SeeAllTableViewCell
        let dest = segue.destination as! AppDetailViewController
        dest.app = allApps[(seeAllTable.indexPath(for: src)?.row)!]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        }
    
    
    // Disabling large navigation bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    // Enabling large navigation bar
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allApps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell5") as! SeeAllTableViewCell
        cell.appName.text = allApps[indexPath.row].trackCensoredName
        cell.appIcon.imageFromURL(urlString: allApps[indexPath.row].artworkUrl100!)
        cell.appDesc.text = allApps[indexPath.row].description
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
