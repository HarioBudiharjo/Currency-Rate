//
//  Formating.swift
//  Currency Rate
//
//  Created by Hario Budiharjo on 03/02/20.
//  Copyright © 2020 Hario Budiharjo. All rights reserved.
//

import Foundation

class Formatting {
    static func beatifyCurrency(currency:Double) -> String{
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        // localize to your grouping and decimal separator
//        currencyFormatter.locale = Locale.
        
        // We'll force unwrap with the !, if you've got defined data you may need more error checking
        
        let priceString = currencyFormatter.string(from: NSNumber(value: currency))!
        return priceString
    }
}

extension String {
    func beatifyCurrency() -> String{
        let currency = Double(self)!
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
//        currencyFormatter.numberStyle = .currency
        // localize to your grouping and decimal separator
        //        currencyFormatter.locale = Locale.
        
        // We'll force unwrap with the !, if you've got defined data you may need more error checking
        
        let priceString = currencyFormatter.string(from: NSNumber(value: currency))!
        return priceString
    }
}
