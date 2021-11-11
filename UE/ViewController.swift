//
//  ViewController.swift
//  UE
//
//  Created by Niki Wang on 10/25/21.
//

import UIKit // for ui
import Auth0 // for login
import CoreLocation // for location tracking
// https://www.appsdeveloperblog.com/determine-users-current-location-example-in-swift/
// trying this tutorial ^^ instead of one I was using before

class ViewController: UIViewController, CLLocationManagerDelegate{
    // creates a variable called locationManager
    // of type CLLocationManager (that's what : is used for)
    // and we're sure it's not null or undefined (that's what the ! is for)
    var locationManager:CLLocationManager!
    override func viewDidLoad(){
        print("view did load")
        super.viewDidLoad()
        createButtons() // creates login button and location tracking button
        // Create a CLLocationManager and assign a delegate
//        let locationManager = CLLocationManager()
//        locationManager.delegate = self

        // Use requestWhenInUseAuthorization if you only need
        // location updates when the user is using your app
//        locationManager.requestWhenInUseAuthorization()
        // Start updating location
//        locationManager.startUpdatingLocation()

        // Make sure to stop updating location when your
        // app no longer needs location updates
//        locationManager.stopUpdatingLocation()
    }
    
    // might remove this
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
        // "dispose of any resources that can be recreated
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        determineMyCurrentLocation()
    }
    
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
            
    }
    
    // https://www.advancedswift.com/user-location-in-swift/
//    func locationManager(
//        _ manager: CLLocationManager,
//        didChangeAuthorization status: CLAuthorizationStatus
//    ) {
//        print("permissions changed")
//        // Handle changes if location permissions
//    }

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        let userLocation:CLLocation = locations[0] as CLLocation
//        if let location = locations.last {
//            let latitude = location.coordinate.latitude
//            let longitude = location.coordinate.longitude
//            // Handle location update
//            print(latitude)
//            print(longitude)
//        }
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
    }

    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print("Error \(error)")
        // Handle failure to get a user’s location
    }
    
    func createButtons(){
        print("creating buttons")
        let button = UIButton(frame:CGRect(x: 0, y: 0, width: 150, height: 150))
        button.center = view.center
        button.configuration = .RecordButton()
        //https://medium.com/doyeona/uibutton-swift-uiaction-closure-based-uicontrol-ios-14-405e255a7640
        button.addTarget(self, action: #selector(recordTrip), for: .touchUpInside)
        view.addSubview(button)
        let loginButton = UIButton(frame:CGRect(x: 0, y: 200, width: 150, height: 150))
//        loginButton.center = view.center
        loginButton.configuration = .LoginButton()
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        view.addSubview(loginButton)
    }
    
    
    
    @objc func recordTrip(){
        print("trip begun!");
    }
    
    @objc func login(){
        Auth0
            .webAuth()
            .scope("openid profile")
            .audience("https://dev-zojyaz8i.us.auth0.com/userinfo")
            .start { result in
                switch result {
                case .failure(let error):
                    // Handle the error
                    print("Error: \(error)")
                case .success(let credentials):
                    // Do something with credentials e.g.: save them.
                    // Auth0 will automatically dismiss the login page
                    print("Credentials: \(credentials)")
                }
        }
        print("logged in!!")
    }
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
    static func LoginButton() -> UIButton.Configuration{
        var config: UIButton.Configuration = .filled()
        config.baseBackgroundColor = .systemOrange
        config.title = "Login"
        config.cornerStyle = .large
        //assign true to show activity using a spinner
        config.showsActivityIndicator = false
        return config
    }
}
