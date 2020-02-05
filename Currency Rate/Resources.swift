//
//  Resources.swift
//  Currency Rate
//
//  Created by Hario Budiharjo on 02/02/20.
//  Copyright © 2020 Hario Budiharjo. All rights reserved.
//

import Foundation
struct Resources {
    private init() {}
    struct String {
        private init() {}
        struct BaseURL {
            static let baseURL = "https://api.ratesapi.io/api/"
        }
        struct endPoint {
            private init() {}
            static let latest = BaseURL.baseURL+"latest"
        }
    }
}
