//  Created by Jeffrey Kozik on 11/15/21.

import UIKit
import CoreLocation // for location tracking

class RecordTripViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager:CLLocationManager! // : means "of type" ! means we know the value isn't undefined or null
    var tripInProgress = false // determine if clicking button should start or stop trip
    var previousLocation:CLLocation! // to calculate distance
    var firstCoordinateFound = false // we don't want to calculate distance until we have two sets of coordinates
    var distanceTraveled:Double = 0
    
    // https://www.appsdeveloperblog.com/determine-users-current-location-example-in-swift/
    // gets users current location if allowed
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    // if user's location has changed, update distance traveled
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
    
    // handle errors
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print("Error \(error)")
    }
    
    @IBOutlet weak var RecordTripButton: UIButton!
    // https://www.dev2qa.com/ios-add-click-event-to-uibutton-swift-example/
    // what happens when button is clicked
    @IBAction func RecordTrip(_ sender: Any) {
        tripInProgress = !tripInProgress
        if(!tripInProgress){
            locationManager.stopUpdatingLocation()
            // https://stackoverflow.com/questions/26326296/changing-text-of-uibutton-programmatically-swift
            RecordTripButton.setTitle("Start Trip", for: .normal);
        }
        else {
            RecordTripButton.setTitle("Stop Trip", for: .normal);
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
