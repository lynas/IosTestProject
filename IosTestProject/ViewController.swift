//
//  ViewController.swift
//  IosTestProject
//
//  Created by sazzad on 1/27/17.
//  Copyright © 2017 Dynamic Solution Innovators. All rights reserved.
//

import UIKit
import FTPopOverMenu_Swift


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func popButtonAction(_ sender: UIButton) {
        let test = false
        var imgArray = [String]()
        if test {
            imgArray.removeAll()
            imgArray.append("menu")
            imgArray.append("resend")
            
        } else {
            imgArray.removeAll()
            imgArray.append("resend")
            imgArray.append("menu")
            
        }
        FTPopOverMenu.showFromSenderFrame(senderFrame: sender.frame,
                                          with: ["wifi/mobile","wifi"],
                                          menuImageArray: imgArray,
                                          done: { (selectedIndex) -> () in
                                            
        }) {
            
        }
    }

}

