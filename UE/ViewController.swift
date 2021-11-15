//  Created by Niki Wang and Jeffrey Kozik on 10/25/21.

import UIKit // for ui
import Auth0 // for login
import CoreLocation // for location tracking

class ViewController: UIViewController, CLLocationManagerDelegate{
    var locationManager:CLLocationManager! // : means "of type" ! means we know the value isn't undefined or null
    var tripInProgress = false
    override func viewDidLoad(){
        super.viewDidLoad()
        createButtons() // creates login button and location tracking button
    }
    
    // https://www.appsdeveloperblog.com/determine-users-current-location-example-in-swift/
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        let userLocation:CLLocation = locations[0] as CLLocation
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
    }

    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print("Error \(error)")
    }
    
    func createButtons(){
        let button = UIButton(frame:CGRect(x: 0, y: 0, width: 150, height: 150))
        button.center = view.center
        button.configuration = .RecordButton()
        //https://medium.com/doyeona/uibutton-swift-uiaction-closure-based-uicontrol-ios-14-405e255a7640
        button.addTarget(self, action: #selector(recordTrip), for: .touchUpInside)
        view.addSubview(button)
        let loginButton = UIButton(frame:CGRect(x: 0, y: 200, width: 150, height: 150))
        loginButton.configuration = .LoginButton()
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        view.addSubview(loginButton)
    }
    
    @objc func recordTrip(){
        tripInProgress = !tripInProgress
        if(!tripInProgress){
            locationManager.stopUpdatingLocation()
        }
        else {
            determineMyCurrentLocation()
        }
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
