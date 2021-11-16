//
//  NewLoginViewController.swift
//  UE
//
//  Created by Niki Wang on 11/16/21.
//

import UIKit

class NewLoginViewController: UIViewController {

    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loginTapped(_ sender: Any) {
    }
    
    @IBAction func createSignUpTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let viewc = storyboard.instantiateViewController(withIdentifier: "newsignup")
        viewc.modalPresentationStyle = .overFullScreen
        present(viewc,animated:true)
        
    }
    
    
}
