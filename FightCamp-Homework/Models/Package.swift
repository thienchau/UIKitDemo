//
//  Package.swift
//  FightCamp-Homework
//
//  Created by Duy Thien Chau on 7/12/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import Foundation

// MARK: - Package

struct Package: Decodable {
    
    var title: String?
    var desc: String?
    var headline: String?
    var thumbnail_urls: [String]?
    var included: [String]?
    var excluded: [String]?
    var payment: String?
    var price: Double?
    var action: String?
}
