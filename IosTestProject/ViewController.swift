//
//  ViewController.swift
//  IosTestProject
//
//  Created by sazzad on 1/27/17.
//  Copyright © 2017 Dynamic Solution Innovators. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let albumName = "SocialCam"
    let pservice = PhotoService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func createButton(_ sender: UIButton) {
        
    }
    
    @IBAction func getButton(_ sender: UIButton) {
        pservice.getAlbum(name: albumName, completion: {
            album in
            print(album?.estimatedAssetCount ?? 0)
            let image = UIImage(named: "IMG_2315")
            
            self.pservice.saveImage(image: image!, toAlbum: self.albumName, completion: {
                (success, error) in
                if error == nil {
                    if success {
                        print("save successful")
                    } else {
                        print("save unsuccess")
                    }
                }
            })
        })
    }
    
    
    
}

