//
//  MainViewController.swift
//  Filmder
//
//  Created by MacNicolas on 19/12/2018.
//  Copyright © 2018 civetdelapin. All rights reserved.
//

import UIKit
import KYDrawerController

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func clicMenuButton(_ sender: UIBarButtonItem) {
        if let drawerController = navigationController?.parent as? KYDrawerController {
            drawerController.setDrawerState(.opened, animated: true)
        }
    }
    
}
