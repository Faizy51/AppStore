//
//  SearchService.swift
//  AppStore
//
//  Created by Faiz Sharief on 24/10/18.
//  Copyright © 2018 . All rights reserved.
//

import Foundation

class SearchService {
    
    var applications : [Application] = []
    
    func download(query: String, completionHandler: @escaping ([Application])->() ) {
        // Encoding the url query
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let url = URL(string: "https://data.42matters.com/api/v2.0/ios/apps/search.json?q=\(encodedQuery!)&access_token=d4b8c0cab059ec95bb6291d2c44349fbc2f992ba")
        print("Have a look at thr url :",url!)
        
        // Object to store results
        var results = Result(number_results: nil, results: nil)
        
        URLSession.shared.dataTask(with: url!) { (data, response, err) in
            //do stuff here
            print("Inside urlsessions")
            guard let data = data else {  return  }
            do {
                results = try JSONDecoder().decode(Result.self, from: data)
//                print("Here are your results :",results.number_results)
                if results.results != nil{
                    
                    // populate the model with the results
                    completionHandler(results.results!)
                }
                
            } catch let err {
                print(err.localizedDescription)
            }
            }.resume()
        
        print("Im out")
    }
    
}
