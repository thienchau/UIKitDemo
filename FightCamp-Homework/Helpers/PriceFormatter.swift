//
//  PriceFormatter.swift
//  FightCamp-Homework
//
//  Created by Duy Thien Chau on 7/12/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import Foundation

// MARK: - PriceFormatter

class PriceFormatter {
    
    // Create a static fomatter to avoid performance issue
    private static var currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumSignificantDigits = 0
        return formatter
    }()
    
    // format double to currency string
    static func format(_ price: Double?) -> String {
        let num: NSNumber = NSNumber(value: price ?? 0)
        return PriceFormatter.currencyFormatter.string(from: num) ?? ""
    }
    
}
