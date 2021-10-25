//
//  ViewController.swift
//  UE
//
//  Created by Niki Wang on 10/25/21.
//

import UIKit
import Auth0
class ViewController: UIViewController{
    override func viewDidLoad(){
        super.viewDidLoad()
        createButton()
    }
    func createButton(){
        let button = UIButton(frame:CGRect(x: 0, y: 0, width: 200, height: 200))
        button.center = view.center
        button.configuration = createConfig()
        view.addSubview(button)
    }

    func createConfig() -> UIButton.Configuration{
        var config: UIButton.Configuration = .tinted()
        config.baseBackgroundColor = .systemGreen
        config.title = "Start"
        config.subtitle = "Recording"
        config.cornerStyle = .large
        //assign true to show activity using a spinner
        config.showsActivityIndicator = true
        return config
    }
}
