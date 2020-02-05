//
//  HomeViewModel.swift
//  Currency Rate
//
//  Created by Hario Budiharjo on 02/02/20.
//  Copyright © 2020 Hario Budiharjo. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import SwiftyJSON

class HomeViewModel {
    
    enum Currency : String{
        case USD = "United State Dollar"
        case AUD = "Australian Dollar"
        case IDR = "Indonesian Rupiah"
        case JPY = "Japanese Yen"
        case empty
        
    }
    
    public let loading : PublishSubject<Bool> = PublishSubject()
    public let sourceCurrency : BehaviorSubject<Currency> = BehaviorSubject(value: .empty)
    public let destCurrency : BehaviorSubject<Currency> = BehaviorSubject(value: .empty)
    public let rateCurrency : BehaviorSubject<String> = BehaviorSubject(value: "")
    public let exchangeCurrency : BehaviorSubject<String> = BehaviorSubject(value: "")
    
    
    public func getData(){
        let url = "\(Resources.String.endPoint.latest)?symbols=\(self.destCurrency.asObserver())&base=\(self.sourceCurrency.asObserver())"
        print("url : \(url)")
        AF.request(url).response { response in
            let json = try? JSON(data: response.data!)
            debugPrint(json!)
            let rate = json!["rates"]["\(self.destCurrency.asObserver())"].stringValue
            self.rateCurrency.onNext(rate)
            print("rate : \(String(describing: rate))")
        }
    }
    
    
}
