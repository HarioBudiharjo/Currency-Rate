//
//  HomeViewController.swift
//  Currency Rate
//
//  Created by Hario Budiharjo on 02/02/20.
//  Copyright © 2020 Hario Budiharjo. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    @IBOutlet weak var sourceRateLabel: UILabel!
    @IBOutlet weak var sourceButton: UIButton!
    @IBOutlet weak var destinationRateLabel: UILabel!
    @IBOutlet weak var destinationButton: UIButton!
    @IBOutlet weak var totalExchangeTextField: UITextField!
    @IBOutlet weak var exchangeButton: UIButton!
    @IBOutlet weak var outputTextView: UITextView!
    @IBOutlet weak var clearBarButton: UIBarButtonItem!
    
    let viewModel = HomeViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        bindRx()
        bindTapRx()
        self.hideKeyboardWhenTappedAround()
    }
    
    private func bindRx(){
        viewModel.sourceCurrency
            .asObserver()
            .skipWhile({ (current) -> Bool in
                current.rawValue == "empty"
            })
            .map{"\($0)"}
            .bind(to: self.sourceRateLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.destCurrency
            .asObserver()
            .skipWhile({ (current) -> Bool in
                current.rawValue == "empty"
            })
            .map{"\($0)"}
            .bind(to: self.destinationRateLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.loading
            .asObserver()
            .subscribe(onNext : { (isLoading) in
                self.showLoadingIndicator(isLoading: isLoading)
            })
            .disposed(by: disposeBag)
        
        self.totalExchangeTextField.rx.text.orEmpty.bind(to: viewModel.exchangeCurrency).disposed(by: disposeBag)
        
        
        let combineOutput = Observable.combineLatest(viewModel.rateCurrency,viewModel.exchangeCurrency){ (rate,exchange) -> String in
            if (rate != "" && exchange != ""){
                let total = (Double(rate) ?? 0.0) * (Double(exchange) ?? 0.0 )
                return "Rate : \(rate.beatifyCurrency())\nExchange : \(exchange.beatifyCurrency())\nTotal exchange: \(String(total).beatifyCurrency())"
            } else {
                return ""
            }
        }
        
        combineOutput.bind(to: outputTextView.rx.text).disposed(by: disposeBag)
    }
    
    private func bindTapRx(){
        sourceButton.rx.tap.bind{
            self.showSelection(status: "source")
            }.disposed(by: disposeBag)
        destinationButton.rx.tap.bind{
            self.showSelection()
            }.disposed(by: disposeBag)
        exchangeButton.rx.tap.bind{
            self.viewModel.getData()
            }.disposed(by: disposeBag)
        clearBarButton.rx.tap.bind{
            self.viewModel.clear()
            }.disposed(by: disposeBag)
    }
    
    private func showSelection(status:String = ""){
        let alertController = UIAlertController(title: status, message: "Pilih kurs \(status) anda?", preferredStyle: .actionSheet)
        
        let idrAction = UIAlertAction(title: "IDR", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            if status == "source" {
                self.viewModel.sourceCurrency.onNext(.IDR)
            } else {
                self.viewModel.destCurrency.onNext(.IDR)
            }
        })
        
        let usdAction = UIAlertAction(title: "USD", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            if status == "source" {
                self.viewModel.sourceCurrency.onNext(.USD)
            } else {
                self.viewModel.destCurrency.onNext(.USD)
            }
        })
        
        let jpyAction = UIAlertAction(title: "JPY", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            if status == "source" {
                self.viewModel.sourceCurrency.onNext(.JPY)
            } else {
                self.viewModel.destCurrency.onNext(.JPY)
            }
        })
        
        let audAction = UIAlertAction(title: "AUD", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            if status == "source" {
                self.viewModel.sourceCurrency.onNext(.AUD)
            } else {
                self.viewModel.destCurrency.onNext(.AUD)
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (alert: UIAlertAction!) -> Void in
            self.dismiss(animated: false, completion: nil)
        })
        
        alertController.addAction(idrAction)
        alertController.addAction(usdAction)
        alertController.addAction(jpyAction)
        alertController.addAction(audAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func showLoadingIndicator(isLoading: Bool){
        if isLoading {
            self.showSpinner(onView: self.view)
        } else {
            self.removeSpinner()
        }
    }
    
}
