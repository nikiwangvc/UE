//
//  ViewController.swift
//  UE
//
//  Created by Niki Wang on 10/25/21.
//

import UIKit
class ViewController: UIViewController{
    override func viewDidLoad(){
        super.viewDidLoad()
        createButton()
    }
    func createButton(){
        let button = UIButton(frame:CGRect(x: 0, y: 0, width: 200, height: 500))
        button.center = view.center
        if #available(iOS 15.0, *) {
            button.configuration = createConfig()
        } else {
            // Fallback on earlier versions
        }
        view.addSubview(button)
    }
    
    @available(iOS 15.0, *)
    func createConfig() -> UIButton.Configuration{
        let config: UIButton.Configuration = .filled()
        
        return config
    }
}
