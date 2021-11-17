//
//  ProfileViewController.swift
//  UE
//
//  Created by mac pro on 11/16/21.
//

import UIKit

// https://www.ioscreator.com/tutorials/picker-ios-tutorial
class ProfileViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var SustainabilityUnitPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SustainabilityUnitPicker.delegate = self
        SustainabilityUnitPicker.dataSource = self
    }
    
    let units = ["Polar Bears Saved","Trees Planted","Tons of CO2 Emissions Reduced"]
    
    func numberOfComponents(in SustainabilityUnitPicker: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ SustainabilityUnitPicker: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return units.count
    }
    
    func pickerView(_ SustainabilityUnitPicker: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return units[row]
    }

    @IBAction func Home(_ sender: Any) {
        let mainStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle :nil)
        let RecordTripsViewController = mainStoryBoard.instantiateViewController(withIdentifier: "RecordTripsViewController") as! RecordTripsViewController
        RecordTripsViewController.modalPresentationStyle = .overFullScreen
        self.present(RecordTripsViewController, animated: true, completion: nil)
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
