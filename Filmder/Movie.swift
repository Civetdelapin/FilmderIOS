//
//  Movie.swift
//  Filmder
//
//  Created by Civetdelapin on 05/01/2019.
//  Copyright © 2019 civetdelapin. All rights reserved.
//

import Foundation

class Movie {
    
    private var id:Int;
    private var title:String;
    private var releaseDate:String;
    private var imagePath:String;
    
    
    init(movieId:Int, movieTitle:String, movieReleaseDate:String, movieImagePath:String){
        
        self.id = movieId
        self.title = movieTitle
        self.releaseDate = movieReleaseDate
        self.imagePath = movieImagePath
        
    }
    
    public func getId() -> Int{
        return self.id
    }
    
    public func getTitle() -> String{
        return self.title
    }
    
    public func getReleaseDate() -> String{
        return self.releaseDate
    }
    
    public func getImagePath() -> String{
        return self.imagePath
    }
}
