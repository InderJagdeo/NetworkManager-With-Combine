//
//  ViewController.swift
//  NetworkLayer
//
//  Created by Macbook on 23/11/22.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    var networkManager = NetworkManager()
    var subscriptions = Set<AnyCancellable>()
    let notificationManager = PushNotification()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestListOfCountries()
        subscribePushNotificationPermission()
    }
}

extension ViewController {
    // MARK: - Subscribers
    
    private func subscribePushNotificationPermission() {
        // Subscribe to changes in remoteNotificationPermission
        notificationManager.$pushNotificationPermission
            .sink { [weak self] permissionStatus in
                // Update your UI or take actions based on the permission status here
                self?.handlePermissionStatus(permissionStatus)
            }
            .store(in: &subscriptions)
        
        // Request remote notification permissions
        notificationManager.requestPushNotificationPermission()
    }
}

extension ViewController {
    // MARK: - User Defined Methods
    
    private func handlePermissionStatus(_ status: PermissionStatus) {
        switch status {
        case .authorized:
            // Permission granted, you can enable notifications or perform actions here
            print("Remote notification permission is authorized.")
            notificationManager.registerForRemoteNotifications()
        default:
            // Permission denied, you can handle this case by showing a message to the user
            print("Remote notification permission is not determind.")
        }
    }
}

extension ViewController {
    // MARK: - Web Requests
    
    private func requestListOfCountries() {
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

