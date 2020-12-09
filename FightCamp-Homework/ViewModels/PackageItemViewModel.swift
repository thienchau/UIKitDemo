
//
//  PackageItemViewModel.swift
//  FightCamp-Homework
//
//  Created by Duy Thien Chau on 7/12/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import Foundation

// MARK: - PackageItemViewModelProtocol

protocol PackageItemViewModelProtocol {
    var title: String { get }
    var desc: String { get }
    var thumbnails: [String] { get }
    var included: String { get }
    var excluded: NSMutableAttributedString { get }
    var payment: String { get }
    var price: String { get }
    var action: String { get }
    var selected: Int { get set }
    var package: Package { get }
}

// MARK: - PackageItemViewModel

class PackageItemViewModel : PackageItemViewModelProtocol {
    
    // uppercased title
    var title: String {
        return package.title?.uppercased() ?? ""
    }
    
    // capitalized title
    var desc: String {
        return package.desc?.capitalized ?? ""
    }
    
    // thumbnails
    var thumbnails: [String] {
        return package.thumbnail_urls ?? ["", "", "", ""]
    }
    
    // merge includeds into 1 string
    var included: String {
        let includeds = package.included ?? []
        let included = includeds.reduce("", { $0 == "" ? $1.capitalized : $0 + "\n" + $1.capitalized })
        return included
    }
    
    // merge excludeds into 1 string
    var excluded: NSMutableAttributedString {
        let excludeds = package.excluded ?? []
        let excluded = excludeds.reduce("", { $0 == "" ? $1.capitalized : $0 + "\n" + $1.capitalized })
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: excluded)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
    // capitalized payment type
    var payment: String {
        return package.payment?.capitalized ?? ""
    }
    
    // format the price
    var price: String {
        return PriceFormatter.format(package.price)
    }
    
    // capitalized action string
    var action: String {
        return package.action?.capitalized ?? ""
    }
    
    // package model
    var package: Package
    
    // selected thumbnail status
    var selected: Int = 0
    
    init(_ package: Package) {
        self.package = package
    }
}
