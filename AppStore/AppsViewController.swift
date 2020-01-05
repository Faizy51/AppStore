//
//  AppsViewController.swift
//  AppStore
//
//  Created by Faiz Sharief on 03/10/18.
//  Copyright © 2018 . All rights reserved.
//

import UIKit

class AppsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var appsTable: UITableView!
    let appdel = UIApplication.shared.delegate as! AppDelegate
    var dummyTitlesArray = ["Popular","Featured"]
    var delegate : SeeAllViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarItem.image = UIImage(named: "apps")
        self.navigationItem.largeTitleDisplayMode = .always
        
        NotificationCenter.default.addObserver(forName: Notification.Name("reload"), object: nil, queue: OperationQueue.main, using: didDownloadData(notif:))
        
        configureInitialScreen()
        addNavigationButton()
    }
    
    @objc func didDownloadData(notif: Notification) {
        if (notif.userInfo!["hasData"] as! Bool) == false {
            let alert = UIAlertController(title: "No Internet", message: "Try after switching the data ON.", preferredStyle: .alert)
            let button = UIAlertAction(title: "Retry", style: .default, handler: { (_) in
                self.appdel.downloadInitialApps()
            })
            alert.addAction(button)
            self.present(alert, animated: true, completion: nil)
        }
        else {
            self.appsTable.delegate = self
            self.appsTable.dataSource = self
            self.appsTable.reloadData()
            self.activity.removeFromSuperview()
            self.loadingLabel.isHidden = true
            self.appsTable.isHidden = false
        }
    }
    
    func addNavigationButton(){
        let button = UIImageView(image: #imageLiteral(resourceName: "faiz"))
        
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        self.navigationController?.navigationBar.addSubview(button)
        NSLayoutConstraint.activate([
            button.rightAnchor.constraint(equalTo: (self.navigationController?.navigationBar.rightAnchor)!,
                                             constant: -16),
            button.bottomAnchor.constraint(equalTo: (self.navigationController?.navigationBar.bottomAnchor)!,
                                              constant: -12),
            button.heightAnchor.constraint(equalToConstant: 40),
            button.widthAnchor.constraint(equalTo: button.heightAnchor)
            ])
    }
    
    func configureInitialScreen() {
        // If apps are not downloaded, show activity indicator with loading...
        if appdel.allDownloadedApps.count == 0 {
            self.appsTable.isHidden = true
            self.activity.hidesWhenStopped = true
            self.activity.startAnimating()
        }
        else {
            self.appsTable.delegate = self
            self.appsTable.dataSource = self
            self.loadingLabel.isHidden = true
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("Removing observer.")
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "reload"), object: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seg1" {
            
            // Send appropriate App object
            let src = sender as! InnerTableViewCell
            let collCell = src.superview?.superview?.superview as! CollectionViewCellTwo
            let indexForSelectedRow = collCell.innerTable.indexPath(for: src)
            let dest = segue.destination as! AppDetailViewController

            dest.app = collCell.tableData?.applications![(indexForSelectedRow?.row)!]
        }
        
        else{
            // 'See all' button clicked
            let src = (sender as! UIButton).superview?.superview as! TableViewCellTwo
            let destination = segue.destination as! SeeAllViewController
            
            // Now use delegation here
            self.delegate = destination
            
            let index = self.appsTable.indexPath(for: src)
            guard let a = (appdel.noOfRows![(index?.row)!-1].collectionCells![0].applications), let b = (appdel.noOfRows![(index?.row)!-1].collectionCells![1].applications)
            else { return }
            
            delegate?.allApps = a + b
        }
    }
    
    // TableView delegate and datasource.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell? = nil
        if indexPath.row == 0{
            cell = appsTable.dequeueReusableCell(withIdentifier: "cell3") as! TableViewCellOne
        }
        else{
            cell = appsTable.dequeueReusableCell(withIdentifier: "cell4") as! TableViewCellTwo
            (cell as! TableViewCellTwo).sectionTitle.text = dummyTitlesArray[indexPath.row-1]
            (cell as! TableViewCellTwo).rowData = self.appdel.noOfRows?[indexPath.row-1]
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 275
        }
        return 230
    }
}
