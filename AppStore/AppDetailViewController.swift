//
//  AppDetailViewController.swift
//  AppStore
//
//  Created by Faiz Sharief on 06/10/18.
//  Copyright © 2018 . All rights reserved.
//

import UIKit

class AppDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var appDesc: UILabel!
    @IBOutlet weak var appIcon: UIImageView!
    @IBOutlet weak var collection: UICollectionView!
    var app : Application?
    
    @IBAction func more(_ sender: UIButton) {
    }
    
    @IBAction func getButton(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AlertViewController")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // This Controller doesn't need large navigation Bar. Configuring that with the two methods.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        // Check if image is there in the cache
        if let imageFromCache = imageCache.object(forKey: NSString(string: (app!.artworkUrl100!))) {
            appIcon.image = imageFromCache
        }
        else {
            appIcon.imageFromURL(urlString: (app?.artworkUrl100!)! )
        }
        appDesc.text = app?.description
        appName.text = app?.trackCensoredName
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (app?.screenshotUrls?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell6", for: indexPath) as! ScreenCollectionViewCell
        cell.imageScreen.imageFromURL(urlString: (app?.screenshotUrls![indexPath.row])!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collection.frame.width * 0.75, height: self.collection.frame.height)
    }
}

// cache to store the downloaded image.
let imageCache = NSCache<NSString, UIImage>()

// Download url imge
extension UIImageView {
    
    public func imageFromURL(urlString: String) {
        if let imageFromCache = imageCache.object(forKey: NSString(string: urlString)) {
            self.image = imageFromCache
            return
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.startAnimating()
        if self.image == nil{
            self.addSubview(activityIndicator)
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        }
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error ?? "No Error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let imageToCache = UIImage(data: data!)
                activityIndicator.removeFromSuperview()
                imageCache.setObject(imageToCache!, forKey: NSString(string: urlString))
                self.image = imageToCache
            })
        }).resume()
    }
}
