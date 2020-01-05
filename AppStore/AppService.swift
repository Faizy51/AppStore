//
//  File.swift
//  AppStore
//
//  Created by Faiz Sharief on 24/10/18.
//  Copyright © 2018 . All rights reserved.
//

import Foundation

class AppService {
    
    var listOfApplications : [Application] = []
    
    func download(handler: @escaping ([Application]?)->() ){
        
        let url = URL(string: "https://data.42matters.com/api/v2.0/ios/apps/top_appstore_charts.json?list_name=topselling_free&device_type=iphone&country=IN&limit=12&access_token=d4b8c0cab059ec95bb6291d2c44349fbc2f992ba")
        print("Have a look at thr url :",url!)
        
        // Object to store results
        var results = AppList(app_list: nil)
        
        URLSession.shared.dataTask(with: url!) { (data, response, err) in
            //do stuff here
            guard let data = data, response != nil else {  handler(nil); return  }
            do {
                results = try JSONDecoder().decode(AppList.self, from: data)
//                print("Here are your results :",results.app_list?.count)
                if results.app_list != nil {
                    for objects in results.app_list!{
                        print(objects.trackCensoredName!)
                    }
                    // populate the model with the results
                    handler(results.app_list!)
                }
                
            } catch let err {
                print(err.localizedDescription)
            }
            }.resume()
        
//        print("Im out")
        
    }
    
}
