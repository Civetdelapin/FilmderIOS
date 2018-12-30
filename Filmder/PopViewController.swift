//
//  PopViewController.swift
//  Filmder
//
//  Created by MacNicolas on 21/12/2018.
//  Copyright © 2018 civetdelapin. All rights reserved.
//

import UIKit
import TMDBSwift

class PopViewController: UIViewController {
    
    var movie : DiscoverMovieMDB!
    
    @IBOutlet weak var posterUIImageView: UIImageView!
    @IBOutlet weak var titleUILable: UILabel!
    @IBOutlet weak var lengthUILabel: UILabel!
    @IBOutlet weak var dateUILable: UILabel!
    
    @IBOutlet weak var genresUILabel: UILabel!
    @IBOutlet weak var scoreUILabel: UILabel!
    @IBOutlet weak var synopsisUILabel: UITextView!
    @IBOutlet weak var directorUILable: UILabel!
    @IBOutlet weak var writersUILabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleUILable.text = movie.title
        synopsisUILabel.text = movie.overview
        scoreUILabel.text = String(movie.vote_average! * 10) + "%"
        dateUILable.text = movie.release_date
        
        genresUILabel.text = ""
        /* IMPOSSIBLE NE MARCHE PAS ET JE SAIS PAS POURQUOI
        for number in 0..<(movie.genreIds!.count){
            movie.genreIds[number]
        }
        */
        
        var urlString = "https://image.tmdb.org/t/p/original"+(movie.backdrop_path)!
        
        
        let url = URL(string: urlString)
        posterUIImageView.kf.setImage(with: url)
        
        
        MovieMDB.credits(movieID: movie.id){
            apiReturn, credits in
            if let credits = credits{
                for crew in credits.crew{
                    
                    //SHOULD HANDLE MULTIPLE DIRECTORS AND WRITERS
                    if(crew.job == "Director"){
                        self.directorUILable.text = crew.name
                    }else if (crew.job == "Screenplay"){
                        self.writersUILabel.text = crew.name
                    }
                    
                    
                }
                
                /*
                for cast in credits.cast{
                    print(cast.character)
                    print(cast.name)
                    print(cast.order)
                }
                 */
            }
        }
        
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
