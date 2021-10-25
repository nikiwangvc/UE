//
//  ViewController.swift
//  UE
//
//  Created by Niki Wang on 10/25/21.
//

import UIKit
import Auth0
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate{
    override func viewDidLoad(){
        super.viewDidLoad()
        createButton()
        // Create a CLLocationManager and assign a delegate
        let locationManager = CLLocationManager()
        locationManager.delegate = self

        // Use requestWhenInUseAuthorization if you only need
        // location updates when the user is using your app
        locationManager.requestWhenInUseAuthorization()
    }
    func createButton(){
        let button = UIButton(frame:CGRect(x: 0, y: 0, width: 150, height: 150))
        button.center = view.center
        button.configuration = .RecordButton()
        //https://medium.com/doyeona/uibutton-swift-uiaction-closure-based-uicontrol-ios-14-405e255a7640
//        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        button.addTarget(self, action: #selector(recordTrip), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc func recordTrip(){

    }
    
//    @objc func login(){
//        Auth0
//            .webAuth()
//            .scope("openid profile")
//            .audience("https://dev-zojyaz8i.us.auth0.com/userinfo")
//            .start { result in
//                switch result {
//                case .failure(let error):
//                    // Handle the error
//                    print("Error: \(error)")
//                case .success(let credentials):
//                    // Do something with credentials e.g.: save them.
//                    // Auth0 will automatically dismiss the login page
//                    print("Credentials: \(credentials)")
//                }
//        }
//        print("logged in!!")
//    }
}
//using extension UIButton to add more buttons in the future
extension UIButton.Configuration{
    static func RecordButton() -> UIButton.Configuration{
        var config: UIButton.Configuration = .filled()
        config.baseBackgroundColor = .systemOrange
        config.title = "Start"
        config.subtitle = "Recording"
        config.cornerStyle = .large
        //assign true to show activity using a spinner
        config.showsActivityIndicator = false
        return config
    }
}
