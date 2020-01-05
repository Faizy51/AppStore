//
//  42Matters.swift
//  AppStore
//
//  Created by Faiz Sharief on 22/10/18.
//  Copyright © 2018 . All rights reserved.
//

//: Playground - noun: a place where people can play

import Foundation
import UIKit

struct AppList: Decodable {
    var app_list : [Application]?
}

struct Result: Decodable {
    let number_results: Int?
    let results: [Application]?
}

struct Application: Decodable {
    let artworkUrl100: String?
    let trackCensoredName: String?
    var screenshotUrls: [String]?
    let description:String?

}

