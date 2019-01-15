//
//  ToSeeTableViewController.swift
//  Filmder
//
//  Created by MacNicolas on 20/12/2018.
//  Copyright © 2018 civetdelapin. All rights reserved.
//

import UIKit

class ToSeeTableViewController: UITableViewController {

    private var movieArray: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("WILL APPEAR TO SEE")
        
        movieArray = DataBase.GetInstance().getMovies(wichList: DataBase.TO_SEE)
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movieArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieToSeeCell", for: indexPath) as! MovieToSeeTableViewCell

        // Configure the cell...
        cell.toSeeTitle?.text = movieArray[indexPath.item].getTitle()
        cell.toSeeDateText?.text = movieArray[indexPath.item].getReleaseDate()
        
        let urlString = "https://image.tmdb.org/t/p/original"+(movieArray[indexPath.item].getImagePath())
        
        let url = URL(string: urlString)
        cell.toSeeImageView.kf.setImage(with: url)
        
        cell.toSeeButton.tag = indexPath.item
        cell.toSeeButton.addTarget(self, action: #selector(ToSeeTableViewController.buttonPressed(sender:)), for: .touchUpInside)
        
        print("made row" + String(indexPath.item))
        
        return cell
    }
    
    @objc func buttonPressed(sender: UIButton){
        
        DataBase.GetInstance().updateMovieList(movieId: movieArray[sender.tag].getId(), newList: DataBase.ARCHIVED)
        
        movieArray.remove(at: sender.tag)
        
        let contentOffset = self.tableView.contentOffset
        self.tableView.reloadData()
        self.tableView.layoutIfNeeded()
        self.tableView.setContentOffset(contentOffset, animated: false)
        
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
