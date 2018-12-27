//
//  MenuViewController.swift
//  Filmder
//
//  Created by MacNicolas on 19/12/2018.
//  Copyright © 2018 civetdelapin. All rights reserved.
//

import UIKit
import KYDrawerController

class MenuViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let mainTabBarController:MainTabBarController = MainTabBarController()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController:UITabBarController = storyboard.instantiateViewController(withIdentifier: "mainTabBarController") as! UITabBarController
        let mainNavigationController:UINavigationController =            storyboard.instantiateViewController(withIdentifier: "mainNavigationController") as! UINavigationController
        let ky:KYDrawerController =            storyboard.instantiateViewController(withIdentifier: "kyDrawerController") as! KYDrawerController
        
        
        print(mainTabBarController.title)
        print(mainTabBarController.selectedIndex)
        
        switch indexPath.row {
        case 0:
            print("Découvrir")
            mainTabBarController.selectedIndex = 0
        case 1:
            print("Films à voir")
            mainTabBarController.selectedIndex = 1
        case 2:
            print("Films archivés")
            mainTabBarController.selectedIndex = 2
        case 3:
            print("Paramètres")
        case 4:
            print("A propos")
        default:
            print("Option de menu introuvable")
        }
        
        print(mainTabBarController.selectedIndex)
        
        
        ///// RIEN NE FONCTIONNE /////
        
        //show(mainTabBarController, sender: self)
        
        //setDrawerStat(false, true)
        
        //self.navigationController?.setViewControllers([mainTabBarController], animated: true)
        
        //self.present(mainTabBarController, animated: true, completion: nil)
        
        //self.present(ky, animated: false, completion: nil)
        
        //mainNavigationController.pushViewController(mainTabBarController, animated: true)
        //mainNavigationController.present(mainTabBarController, animated: true, completion: nil)
        
        //ky.mainViewController = mainTabBarController
        
        //self.navigationController?.pushViewController(mainTabBarController, animated: true)
    }


}
