//  Created by Jeffrey Kozik on 11/15/21.

import UIKit
import CoreLocation // for location tracking

class RecordTripViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager:CLLocationManager! // : means "of type" ! means we know the value isn't undefined or null
    var tripInProgress = false
    var previousLocation:CLLocation!
    var firstCoordinateFound = false
    var distanceTraveled:Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        if (!firstCoordinateFound){
            firstCoordinateFound = true
        }
        else {
            distanceTraveled += userLocation.distance(from:previousLocation) // in meters
        }
        previousLocation = userLocation
        let currentLatitude = userLocation.coordinate.latitude
        let currentLongitude = userLocation.coordinate.longitude
        print("user latitude = \(currentLatitude)")
        print("user longitude = \(currentLongitude)")
        print("distance traveled = \(distanceTraveled)")
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print("Error \(error)")
    }
    
    @IBAction func RecordTrip(_ sender: Any) {
        tripInProgress = !tripInProgress
        if(!tripInProgress){
            locationManager.stopUpdatingLocation()
        }
        else {
            determineMyCurrentLocation()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
