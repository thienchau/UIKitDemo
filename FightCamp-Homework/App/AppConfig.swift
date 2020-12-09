//
//  AppConfig.swift
//  FightCamp-Homework
//
//  Created by Duy Thien Chau on 7/12/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import Foundation

protocol AppConfigProtocol {
    var jsonFile: String { get }
    var THUMB_NUM: Int { get }
}

struct AppConfig: AppConfigProtocol {
    let jsonFile = "packages"
    let THUMB_NUM = 4
}
