//
//  Formating.swift
//  Currency Rate
//
//  Created by Hario Budiharjo on 03/02/20.
//  Copyright © 2020 Hario Budiharjo. All rights reserved.
//

import Foundation

extension String {
    func beatifyCurrency() -> String{
        if let value = Double(self) {
            let formatter = NumberFormatter()
            formatter.currencySymbol = ""
            formatter.numberStyle = .currency
            formatter.maximumFractionDigits = 2
            if let str = formatter.string(for: value) {
                return str
            }
        }
        return ""
    }
}
