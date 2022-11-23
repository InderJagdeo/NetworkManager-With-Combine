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
    var networkManager = NetworkManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        let request = CountryRequest()
        networkManager.request(request)
            .sink { (completion) in
                switch completion {
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                case .finished:
                    print("Finished")
                }
            } receiveValue: { (countries) in
                print("Number of countries - \(countries.count) countries")
            }
            .store(in: &subscriptions)
    }
}

