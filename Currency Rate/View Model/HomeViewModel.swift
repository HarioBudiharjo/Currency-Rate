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
        loading.onNext(true)
        let url = try! "\(Resources.String.endPoint.latest)?symbols=\(self.destCurrency.value())&base=\(self.sourceCurrency.value())"
        AF.request(url).response { response in
            let json = try? JSON(data: response.data!)
            let rate = json!["rates"]["\(try! self.destCurrency.value())"].stringValue
            self.rateCurrency.onNext(rate)
            self.loading.onNext(false)
        }
    }
    
    public func clear(){
        sourceCurrency.onNext(HomeViewModel.Currency.empty)
        destCurrency.onNext(HomeViewModel.Currency.empty)
        rateCurrency.onNext("")
        exchangeCurrency.onNext("")
    }
    
    
}
