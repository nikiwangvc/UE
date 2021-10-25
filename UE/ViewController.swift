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
        let button = UIButton(frame:CGRect(x: 0, y: 0, width: 200, height: 200))
        button.center = view.center
        button.configuration = createConfig()
        view.addSubview(button)
    }

    func createConfig() -> UIButton.Configuration{
        var config: UIButton.Configuration = .tinted()
        config.baseBackgroundColor = .systemGreen
        config.title = "Start recording"
        return config
    }
}
