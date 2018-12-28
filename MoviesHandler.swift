//
//  MoviesHandler.swift
//  Filmder
//
//  Created by Civetdelapin on 28/12/2018.
//  Copyright © 2018 civetdelapin. All rights reserved.
//

import Foundation
import TMDBSwift

class MoviesHandler {
    
    private static var moviesHandler: MoviesHandler?
    private var movies = [DiscoverMovieMDB]()
    private var nbPage:Int = 0;
    
    
    static func GetInstance()->MoviesHandler{
        
        if(moviesHandler == nil){
            moviesHandler = MoviesHandler()
        }
        
        return moviesHandler!
    }
    
    private init() {
        
    }
    
    ///Get new movies via an Async tasks TODO : Add filter
    private func GetNewMovies(completion: @escaping (_ data: DiscoverMovieMDB?) -> ()){
        
        nbPage = nbPage + 1
        
        DiscoverMovieMDB.discoverMovies(language: "fr-FR", page: nbPage){ data, movieArr in
            if let movieArr = movieArr{
                self.movies = movieArr
                
                completion(movieArr[0])
            }
        }
        
    }
    
    ///Get the current movie, and if needed get new ones
    public func GetMovie(completion: @escaping (_ data: DiscoverMovieMDB?) -> ()){
        if(movies.count == 0){
            GetNewMovies(completion: completion)
        }else {
            completion(movies[0])
        }
    }
    
    public func GetMovieAtIndex(index:Int, completion: @escaping (_ data: DiscoverMovieMDB?) -> ()){
        
        if(index >= 0 && index <= movies.count - 1) {
            completion(movies[index])
        }else {
            GetNewMovies(completion: completion)
        }
    }
    
    public func GetMovieAtIndex(index:Int) -> DiscoverMovieMDB? {
        
        if(index >= 0 && index <= movies.count - 1) {
            return movies[index]
        }else {
            return nil
        }
        
    }
    
    ///Get the next movies, and if needed get new ones
    public func GetNextMovie(completion: @escaping (_ data: DiscoverMovieMDB?) -> ()){
        
        if(movies.count == 1){
            GetNewMovies(completion: completion)
        }else {
            movies.removeFirst()
            GetMovie(completion: completion)
        }
        
    }
}
