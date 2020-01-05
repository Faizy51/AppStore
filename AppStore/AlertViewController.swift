//
//  AlertViewController.swift
//  AppStore
//
//  Created by Faiz Sharief on 12/10/18.
//  Copyright © 2018 . All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {


    @IBOutlet weak var container: UIView!
    @IBAction func close(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
