//
//  MoviesHandler.swift
//  Filmder
//
//  Created by REY BAPTISTE on 19/12/2018.
//  Copyright © 2018 civetdelapin. All rights reserved.
//

import Foundation
import TMDBSwift

class MoviesHandler {
    
    private static var moviesHandler: MoviesHandler?
    private var movies = [DiscoverMovieMDB]()
    
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
        
        DiscoverMovieMDB.discoverMovies(language: "FR", page: 1){ data, movieArr in
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
