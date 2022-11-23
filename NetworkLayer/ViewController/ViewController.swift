//
//  ViewController.swift
//  NetworkLayer
//
//  Created by Macbook on 23/11/22.
//

import UIKit
import Combine

class ViewController: UIViewController {

    var subscriptions = Set<AnyCancellable>()
    var networkClient = NetworkRequest()

    override func viewDidLoad() {
        super.viewDidLoad()

        networkClient.dataRequest(CountryRequest())
            .sink { (completion) in
                switch completion {
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                case .finished:
                    print("Do your stuff here.")
                }
            } receiveValue: { (countries) in
                print("Number of countries - \(countries.count) countries")
            }
            .store(in: &subscriptions)
    }
}

