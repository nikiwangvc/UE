//  Created by Jeffrey Kozik on 11/16/21.

import UIKit
import Charts
import Firebase
import FirebaseCore
import FirebaseFirestore

class TripHistoryViewController: UIViewController, ChartViewDelegate {

    var lineChart = LineChartView()
    var db: Firestore!
    let defaults = UserDefaults.standard
    var thisUid = "not assigned yet"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        thisUid = defaults.object(forKey: "uid") as! String ?? "no uid yet"
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        
        lineChart.delegate = self
        // Do any additional setup after loading the view.
        //https://www.youtube.com/watch?v=J9hl7HHXNHU
//    }
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
        
        lineChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width,
                                 height: self.view.frame.size.width)
        lineChart.center = view.center
        view.addSubview(lineChart)
        
        var entries = [ChartDataEntry]()
        let docRef1 = db.collection("users").document(thisUid)
        docRef1.getDocument{ (document, error) in
            if let document = document {
                let numTrips: Int = document.get("numTrips") as! Int
                print("numTrips \(numTrips)")
                let docRef2 = self.db.collection("users").document(self.thisUid).collection("trips").document("document")
                docRef2.getDocument{ (document2, error) in
                    if let document2 = document2 {
                        var counter = 1
                        var retrievedTripArray: [[Double]] = []
                        
                        while(counter <= numTrips){
                            let countString = String(counter) as! String
                            let thisTrip =  document2.get(countString) as! [Double]
                            retrievedTripArray.append(thisTrip)
                            counter += 1
                        }
                        print("retrievedTripArray \(retrievedTripArray)")
                        for trip in retrievedTripArray{
                            print("trip[0] \(trip[0])")
                            print("trip[1] \(trip[1])")
                            let formatter = DateFormatter()
                            formatter.dateFormat = "MM-dd-yyyy"
                            let dateString = String(Int(trip[1])) + "-" + String(Int(trip[2])) + "-" + String(Int(trip[3]))
                            print("dateString \(dateString)")
                            let someDateTime = formatter.date(from: dateString)
                            print("someDateTime \(someDateTime)")
                            let unixtime = someDateTime?.timeIntervalSince1970
                            print("unixtime \(unixtime)")
                            entries.append(ChartDataEntry(x: unixtime!, y: trip[0]))
                        }
                        
                        let xAxis = self.lineChart.xAxis
                        xAxis.labelPosition = .bottom
                        xAxis.labelCount = entries.count
                        xAxis.drawLabelsEnabled = true
                        xAxis.drawLimitLinesBehindDataEnabled = true
//                      XAxis.avoidFirstLastClippingEnabled = true
                        
                        // set the x values date formatter
                        let xValuesNumberFormatter = ChartXAxisFormatter()
                        xValuesNumberFormatter.dateFormatter = DateFormatter()
                        xValuesNumberFormatter.dateFormatter!.dateFormat = "MM-dd"
                        xAxis.valueFormatter = xValuesNumberFormatter
                        
                        let set = LineChartDataSet(entries: entries)
                        set.colors = ChartColorTemplates.material()
                        
                        let data = LineChartData(dataSet: set)
                        self.lineChart.data = data
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Statistics"
    }
}
