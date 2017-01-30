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
        pservice.createAlbum(name: albumName, completion: {
            ph in
            
        })
    }
    
    @IBAction func getButton(_ sender: UIButton) {
        pservice.getAlbum(name: albumName, completion: {
            album in
            print(album?.estimatedAssetCount ?? 0)
        })
    }
    
    
    
}

