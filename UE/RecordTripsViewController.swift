//  Created by Jeffrey Kozik on 11/15/21.



import UIKit // for UI

import CoreLocation // for location tracking

import Firebase // for CRUD

import FirebaseCore

import FirebaseFirestore



class RecordTripsViewController: UIViewController, CLLocationManagerDelegate, UIPickerViewDelegate, UIPickerViewDataSource{

    

    var locationManager:CLLocationManager!

    var tripInProgress = false // determine if clicking button should start or stop trip

    var previousLocation:CLLocation! // to calculate distance

    var firstCoordinateFound = false // we don't want to calculate distance until we have two sets of coordinates

    var distanceTraveled:Double = 0

    var co2Score:Double = 0

    var db: Firestore!

    let defaults = UserDefaults.standard

    var thisUid = "not assigned yet"

    @IBOutlet weak var RecordTripButton: UIButton!

    @IBOutlet weak var transportPicker: UIPickerView!

    // walking 0.03 -> saves 0.54 pounds/mile 0.54 lb/1 mi * 1 mi/1.61 km * 1 kg /2.20 lbs = 0.54*0.28 = 0.15 kg/km

    // running 0.06 -> saves 0.51 -> 0.14

    // hybrid 0.18 -> saves 0.39 -> 0.11

    // train 0.28 -> saves 0.29 -> 0.08

    // bus 0.52 -> saves 0.05 -> 0.01

    // ev 0.09 -> saves 0.48 0> 0.13

    // motorcyel 0.28 -> saves 0.29 -> 0.08

    // plane -> 0.47 saves 0.10 -> 0.03

    // Input the data into the array

    let transportPickerData = ["walking", "running", "hybrid car", "passenger train", "bus", "electric car", "motorcycle", "plane"]

    let kgPerKmCO2 = [0.15, 0.14, 0.11, 0.08, 0.01, 0.13, 0.08, 0.03]

    var transportRetrieved = false

    

    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        title = "Record"


        transportPicker.setValue(UIColor.black, forKey: "textColor")

//        determineMyCurrentLocation()

        thisUid = defaults.object(forKey: "uid") as! String ?? "no uid yet"

        print("thisUid \(thisUid)")

        let settings = FirestoreSettings()

        Firestore.firestore().settings = settings

        db = Firestore.firestore()

        let docRef = db.collection("users").document(thisUid)

        print("docRef \(docRef)")

        docRef.getDocument{ (document, error) in

            if let document = document {

                let kilometersTraveled: Double = document.get("kilometersTraveled") as! Double

                let kilometersTraveledText: String = String(format: "%.4f", kilometersTraveled)

                let co2Score: Double = document.get("co2") as! Double

                let co2ScoreText: String = String(format: "%.4f", co2Score)

                self.DistanceTraveledLabel.text = "Distance Traveled \(kilometersTraveledText) kilometers"

                self.SustainabilityScoreLabel.text = "Sustainability Score \(co2ScoreText) kg CO2 saved";

                if (document.get("tripInProgress") as! Bool == true){

                    self.RecordTripButton.setTitle("End Trip", for: .normal)

                    self.tripInProgress = true

                }

                else {

                    self.RecordTripButton.setTitle("Start Trip", for: .normal)

                    self.tripInProgress = false

                }

//                let currentFormIndexString = document.get("formOfTransport") as! String
//
//                let currentFormIndex = Int(currentFormIndexString)!
                
                let currentFormIndex = document.get("formOfTransport") as! Int

                print("currentFormIndex \(currentFormIndex)")

                self.transportPicker.selectRow(currentFormIndex, inComponent: 0, animated: false)

                self.transportRetrieved = true

            } else {

                print("Document does not exist in cache")

            }

        }

    }

    

    override func viewDidLoad() {

        super.viewDidLoad()
        

        // Connect data:

        self.transportPicker.delegate = self

        self.transportPicker.dataSource = self

        //Looks for single or multiple taps.

         let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.

        //tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)

    }

    
    // Number of columns of data

   func numberOfComponents(in pickerView: UIPickerView) -> Int {

       return 1

   }

   

    
   // The number of rows of data

   func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

       return transportPickerData.count

   }

   

   // The data to return fopr the row and component (column) that's being passed in

   func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

       let currentTransportIndex = transportPicker.selectedRow(inComponent: 0).description

       print("currentTransportIndex \(currentTransportIndex)")

       if(self.transportRetrieved){

           self.db.collection("users").document(thisUid).updateData([

               "formOfTransport": Int(currentTransportIndex)

           ])

       }

       return transportPickerData[row]

   }

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: transportPickerData[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
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

    @IBOutlet weak var SustainabilityScoreLabel: UILabel!

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

            

            let kilometersTraveled: Double = (distanceTraveled / 1000) as! Double

            let currentTransportIndex = transportPicker.selectedRow(inComponent: 0).description

            co2Score += (kilometersTraveled * kgPerKmCO2[Int(currentTransportIndex)!])

            let kilometersTraveledText: String = String(format: "%.4f", kilometersTraveled)

            self.db.collection("users").document(thisUid).updateData([

                "kilometersTraveled": kilometersTraveled,

                "co2": co2Score

            ])

            

            DistanceTraveledLabel.text = "Distance Traveled \(kilometersTraveledText) kilometers"

            let co2ScoreText: String = String(format: "%.4f", co2Score)

            SustainabilityScoreLabel.text = "Sustainability Score \(co2ScoreText) kg CO2 saved";

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

    

    // https://www.dev2qa.com/ios-add-click-event-to-uibutton-swift-example/

    // what happens when button is clicked

    @IBAction func RecordTrip(_ sender: Any) {

        tripInProgress = !tripInProgress

        self.db.collection("users").document(thisUid).updateData([

            "tripInProgress": tripInProgress

        ])

        if(!tripInProgress){

            locationManager.stopUpdatingLocation()

            firstCoordinateFound = false

            distanceTraveled = 0

            let docRef = db.collection("users").document(thisUid)

            print("docRef \(docRef)")

            docRef.getDocument{ (document, error) in

                if let document = document {

                    var numTripsPlusOne = document.get("numTrips") as! Int

                    numTripsPlusOne += 1

                    let myCO2 = document.get("co2") as! Double

                    var thisTrip: [Double] = []

                    thisTrip.append(myCO2)

                    print("myCO2 \(myCO2)")

                    let calendar = Calendar.current

                    let date = Date()

                    let year = Double(calendar.component(.year, from: date))

                    let month = Double(calendar.component(.month, from: date))

                    let day = Double(calendar.component(.day, from: date))

                    thisTrip.append(month)

                    thisTrip.append(day)

                    thisTrip.append(year)

                    self.db.collection("users").document(self.thisUid).collection("trips").document("document").updateData([

                        String(numTripsPlusOne): thisTrip

                    ])

                    self.db.collection("users").document(self.thisUid).updateData([

                        "numTrips": numTripsPlusOne

                    ])

                    self.db.collection("users").document(self.thisUid).updateData([

                        "kilometersTraveled": 0,

                        "co2": 0

                    ])

                } else {

                    print("Document does not exist in cache")

                }

            }

            distanceTraveled = 0

            DistanceTraveledLabel.text = "Distance Traveled 0.0000 kilometers"

            co2Score = 0

            SustainabilityScoreLabel.text = "Sustainability Score 0.0000 kg CO2 saved"

            // https://stackoverflow.com/questions/26326296/changing-text-of-uibutton-programmatically-swift

            RecordTripButton.setTitle("Start Trip", for: .normal)

        }

        else {

            RecordTripButton.setTitle("End Trip", for: .normal)

            determineMyCurrentLocation()

        }

    }

}



// calculating sustainability score

// 20 pounds CO2 released for 1 gallon gas

// that's 0.01 tons CO2

// A car's average PMPG is 35.7

// Traveling 1 mile by car would have released 1/35.7 gallons of gas which equals 20/35.7 pounds CO2

// 20/35 = 4/7 pounds CO2 released 0.57 pounds CO2 released if you travel a mile by car

// bike: 984 -> 1/984 -> 20/984 = 0.02 pounds CO2 released

// so if you travel 1 mile by bike you're saving the planet 0.55 pounds CO2

// 1 tree = 22 pounds a year, so once you reach 22 pounds it's the equivalent of planting a tree for 1 year

// 1 mile by car releases 0.57 pounds CO2

// 1 mile by bike releases 0.02 pounds CO2 -> saves 0.55

// walking 0.03 -> saves 0.54

// running 0.06 -> saves 0.51

// hybrid 0.18 -> saves 0.39

// train 0.28 -> saves 0.29

// bus 0.52 -> saves 0.05

// ev 0.09 -> saves 0.48

// motorcyel 0.28 -> saves 0.29

// plane -> 0.47 saves 0.10

// pounds vs kg



//let usersWhoMatchSearchedEmail = db.collection("users").whereField("email", isEqualTo: searchBarValue)
