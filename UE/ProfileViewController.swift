//
//  ProfileViewController.swift
//  UE
//
//  Created by mac pro on 11/16/21.
//

import UIKit
import FirebaseAuth
import Firebase

// https://www.ioscreator.com/tutorials/picker-ios-tutorial
class ProfileViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var SustainabilityUnitPicker: UIPickerView!
    
    @IBOutlet var email: UITextField!
    @IBOutlet var resetButton: UIButton!
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
    
    
    @IBAction func resetPasswordTapped(_ sender: Any) {
        if (email.text?.isEmpty == false) {

                Auth.auth().sendPasswordReset(withEmail: email.text!){(error)in
                    if error == nil{
                        let dialogMessage = UIAlertController(title: "Password reset link sent!", message: "Please check your email inbox and proceed following the instructions.", preferredStyle: .alert)
                    
                    // Create OK button with action handler
                        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                        print("Ok button tapped")
                     })
                    
                    //Add OK button to a dialog message
                        dialogMessage.addAction(ok)
                    // Present Alert to
                        self.present(dialogMessage, animated: true, completion: nil)
                        print("Sent")
                        return
                    }else{
                        let dialogMessage = UIAlertController(title: "User does not exist", message: "Please check your email or proceed to sign up :)", preferredStyle: .alert)
                    
                    // Create OK button with action handler
                        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                        print("Ok button tapped")
                     })
                    
                    //Add OK button to a dialog message
                        dialogMessage.addAction(ok)
                    // Present Alert to
                        self.present(dialogMessage, animated: true, completion: nil)
                        print("Failed - \(String(describing:error?.localizedDescription))")
                        return
                    }
                }

            }
        else {
            let dialogMessage = UIAlertController(title: "Attention", message: "Please enter your email", preferredStyle: .alert)
            // Create OK button with action handler
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                print("Ok button tapped")
            })
    
            //Add OK button to a dialog message
            dialogMessage.addAction(ok)
            // Present Alert to
            self.present(dialogMessage, animated: true, completion: nil)
        }

    }
    
    @IBAction func LogoutTapped(_ sender: Any) {
        let firebaseAuth = Auth.auth()
    do {
      try firebaseAuth.signOut()
    } catch let signOutError as NSError {
      print("Error signing out: %@", signOutError)
    }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "newlogin")
        vc.modalPresentationStyle = .overFullScreen
        present(vc,animated:true)
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
