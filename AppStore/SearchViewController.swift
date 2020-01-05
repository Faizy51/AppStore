//
//  SearchViewController.swift
//  AppStore
//
//  Created by Faiz Sharief on 03/10/18.
//  Copyright © 2018 . All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate {

    let appDel = UIApplication.shared.delegate as! AppDelegate
    var tableData : [Application] = []
    var filteredTableData : [Application]?
    var resultSearchController = UISearchController()
    let controller = UISearchController(searchResultsController: nil)
    @IBOutlet weak var searchTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...9 {
            tableData.append(appDel.allDownloadedApps[i])
        }
        
        // Implement Search Controller
        self.resultSearchController = ({
            
            controller.searchResultsUpdater = self
            controller.obscuresBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.searchBar.searchBarStyle = .minimal
            controller.searchBar.delegate = self
            navigationItem.searchController = controller
            
            return controller
        })()
        
        definesPresentationContext = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.hidesSearchBarWhenScrolling = false
        
        // Reload the table
        self.searchTable.reloadData()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.searchTable.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! AppDetailViewController
        let src = sender as! UITableViewCell
        let ip = searchTable.indexPath(for: src)
        dest.loadView()
        if controller.isActive {
            dest.app = filteredTableData?[(ip?.row)!]
        }
        else{
            dest.app = tableData[(ip?.row)!]
        }
    }

    func updateSearchResults(for searchController: UISearchController) {
        
        // Call the service to download search results
        let downloader = SearchService()
        downloader.download(query: controller.searchBar.text!) { (resultantApps) in
            self.filteredTableData = resultantApps
            DispatchQueue.main.async(execute: {
                self.searchTable.reloadData()
            })
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.resultSearchController.isActive = false
        self.searchTable.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.resultSearchController.isActive) {
            if filteredTableData != nil{
                return self.filteredTableData!.count
            }
            else{
                return 0
            }
        }
        else {
            return self.tableData.count
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1")
        cell?.textLabel?.textColor = UIColor.blue
        if (self.resultSearchController.isActive) {
            cell?.textLabel?.text = "⌕ "+filteredTableData![indexPath.row].trackCensoredName!
            return cell!
        }
        else {
            cell?.textLabel?.text = tableData[indexPath.row].trackCensoredName
            
            return cell!
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
   
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.backgroundColor = UIColor.white
        let label = UILabel(frame: CGRect(x: 14, y: 8, width: 100, height: 22))
        if resultSearchController.isActive{
            label.text = "Results"
        }
        else{
            label.text = "Trending"
        }
        label.font = UIFont.boldSystemFont(ofSize: 19)
        view.addSubview(label)
        return view
    }
    
}
