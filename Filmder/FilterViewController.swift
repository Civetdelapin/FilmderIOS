//
//  FilterViewController.swift
//  Filmder
//
//  Created by MacNicolas on 12/01/2019.
//  Copyright © 2019 civetdelapin. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet weak var genresTableView: UITableView!
    @IBOutlet weak var yearText: UITextField!
    @IBOutlet weak var noteSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Charger les noms des genres dans "genresTableView"
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
