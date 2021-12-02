//  Created by Jeffrey Kozik on 11/15/21.

import UIKit
import CoreLocation // for location tracking
import FirebaseAuth
import Firebase
import FirebaseCore
import FirebaseFirestore

class RecordTripsViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager:CLLocationManager! // : means "of type" ! means we know the value isn't undefined or null
    var tripInProgress = false // determine if clicking button should start or stop trip
    var previousLocation:CLLocation! // to calculate distance
    var firstCoordinateFound = false // we don't want to calculate distance until we have two sets of coordinates
    var distanceTraveled:Double = 0
    var db: Firestore!
    let defaults = UserDefaults.standard
    var thisUid = "not assigned yet"
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            thisUid = defaults.object(forKey: "uid") as! String ?? "no uid yet"
            print(thisUid)
        let settings = FirestoreSettings()

        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        let docRef = db.collection("users").document(thisUid)
        
        docRef.getDocument(source: .cache) { (document, error) in
            if let document = document {
                let kilometersTraveled = document.get("kilometersTraveled")
                // changing it from kilometersTraveled to kilometersTraveled! might work
                self.DistanceTraveledLabel.text = "Distance Traveled \(kilometersTraveled) meters"
            } else {
                print("Document does not exist in cache")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Looks for single or multiple taps.
         let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)
    }

    

    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    // https://www.appsdeveloperblog.com/determine-users-current-location-example-in-swift/
    // gets users current location if allowed
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    
    @IBOutlet weak var DistanceTraveledLabel: UILabel!
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
        self.db.collection("users").document(thisUid).collection("record").document("document").setData([
            "kilometersTraveled": distanceTraveled / 1000
        ])
        previousLocation = userLocation
        let currentLatitude = userLocation.coordinate.latitude
        let currentLongitude = userLocation.coordinate.longitude
        print("user latitude = \(currentLatitude)")
        print("user longitude = \(currentLongitude)")
        print("distance traveled = \(distanceTraveled)")
        DistanceTraveledLabel.text = "Distance Traveled \(distanceTraveled) meters"
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
                RecordTripButton.setTitle("Start Trip", for: .normal)
//                self.db.collection("users").document(self.modelController.uid).collection("trips").document(
            }
            else {
                RecordTripButton.setTitle("Stop Trip", for: .normal)
                determineMyCurrentLocation()
            }
    }
    
    
    
    
    @IBAction func TripHistory(_ sender: Any) {
    let mainStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle :nil)
        let tripHistoryViewController = mainStoryBoard.instantiateViewController(withIdentifier: "TripHistoryViewController") as! TripHistoryViewController
        tripHistoryViewController.modalPresentationStyle = .overFullScreen
        self.present(tripHistoryViewController, animated: true, completion: nil)
        }
    
    
    
    
    @IBAction func Friends(_ sender: Any) {
    let mainStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle :nil)
        let FriendsViewController = mainStoryBoard.instantiateViewController(withIdentifier: "FriendsViewController") as! FriendsViewController
        FriendsViewController.modalPresentationStyle = .overFullScreen
        self.present(FriendsViewController, animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func Profile(_ sender: Any) {
    let mainStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle :nil)
        let ProfileViewController = mainStoryBoard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        ProfileViewController.modalPresentationStyle = .overFullScreen
        self.present(ProfileViewController, animated: true, completion: nil)
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


// calculating sustainability score
// 20 pounds CO2 released for 1 gallon gas
// that's 0.01 tons CO2
// 


//let usersWhoMatchSearchedEmail = db.collection("users").whereField("email", isEqualTo: searchBarValue)

