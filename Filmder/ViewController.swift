//
//  ViewController.swift
//  Filmder
//
//  Created by if26-grp3 on 18/12/2018.
//  Copyright © 2018 civetdelapin. All rights reserved.
//

import UIKit
import TMDBSwift

class ViewController: UIViewController {

    private var apikey = "bb43e72055ce4efbf7bedaad66a91e6d"
    
    @IBOutlet weak var movieId: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var noLikeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TMDBConfig.apikey = self.apikey
        
        MoviesHandler.GetInstance().GetMovie(){ data in
            self.PrintMovie(movie: data!)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func likeButtonOnClick(_ sender: UIButton) {
        
        
        MoviesHandler.GetInstance().GetNextMovie(){ data in
            self.PrintMovie(movie: data!)
        }
    }

    @IBAction func noLikeButtonOnClick(_ sender: UIButton) {
        
        MoviesHandler.GetInstance().GetNextMovie(){ data in
            self.PrintMovie(movie: data!)
        }
    }
    
    
    private func PrintMovie(movie : DiscoverMovieMDB){
        
        self.movieId.text = String(movie.id)
        self.movieTitle.text = movie.title
        
    }
}

