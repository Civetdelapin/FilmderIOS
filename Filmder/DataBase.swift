//
//  DataBase.swift
//  Filmder
//
//  Created by if26-grp3 on 18/12/2018.
//  Copyright © 2018 civetdelapin. All rights reserved.
//

import Foundation
import SQLite
import TMDBSwift

class DataBase {
    
    
    public static let ARCHIVED:Int = 0;
    public static let TO_SEE:Int = 1;
    public static let SEEN:Int = 2;
    
    private static var dataBaseInstance: DataBase?
    
    private var database: Connection!
    
    let movies_table = Table("movies")
    let movies_id = Expression<Int>("id")
    let movies_title = Expression<String>("title")
    let movies_release_date = Expression<String>("release_date")
    let movies_image_path = Expression<String>("image_path")
    
    let movies_types_table = Table("movies_type")
    let movies_types_id_movies = Expression<Int>("id_movies")
    let movies_types_id_types = Expression<Int>("id_types")
    
    let types_table = Table("types")
    let types_id = Expression<Int>("id")
    let types_type = Expression<String>("type")
    
    static func GetInstance()->DataBase{
    
        if(dataBaseInstance == nil){
            dataBaseInstance = DataBase()
        }
    
        return dataBaseInstance!
    }
    

    private init() {
        
        
        // ---------- CREATION DE L'OBJ DATABASE -----------
        
        do
        {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("data_base").appendingPathExtension("sqlite3")
            let base = try Connection(fileUrl.path)
            self.database = base;
        }
        catch
        {
            print (error)
        }
        // -------------------------------------------------
        
        
        // --------- CREATION DES BASES DE DONNEES ---------
        
        let createTableMovies = self.movies_table.create(ifNotExists: true) { table in
            table.column(self.movies_id, primaryKey : true)
            
            table.column(self.movies_title)
            table.column(self.movies_release_date)
            table.column(self.movies_image_path)
        }
        
        let createTableTypes = self.types_table.create(ifNotExists : true){ table in
            table.column(self.types_id, primaryKey : .autoincrement)
            
            table.column(self.types_type)
        }
        
        let createTableMoviesTypes = self.movies_types_table.create(ifNotExists: true){ table in
            table.column(self.movies_types_id_movies)
            table.column(self.movies_types_id_types)
            
            table.primaryKey(self.movies_types_id_types, movies_types_id_movies)
            
            table.foreignKey(self.movies_types_id_movies, references: movies_table, self.movies_id)
            table.foreignKey(self.movies_types_id_types, references: types_table, self.types_id)
        }
        
        
        do {
            
            print("DROP TABLE TYPES")
            try self.database.run(types_table.drop(ifExists : true))
            
            print("DROP TABLE MOVIES")
            try self.database.run(movies_table.drop(ifExists : true))
            
            print("DROP TABLE MOVIES TYPES")
            try self.database.run(movies_types_table.drop(ifExists : true))
            
            print("CREATE TABLE TYPES")
            try self.database.run(createTableTypes)
            
            print("CREATE TABLE MOVIES")
            try self.database.run(createTableMovies)
            
            print("CREATE TABLE MOVIES TYPES")
            try self.database.run(createTableMoviesTypes)

            let tableTypesCount = try database.scalar(types_table.count);
            if(tableTypesCount == 0){
                
                print("INSERT INTO TABLE TYPES")
                try self.database.run(types_table.insert(types_id <- DataBase.ARCHIVED ,types_type <- "Archived"))
                try self.database.run(types_table.insert(types_id <- DataBase.TO_SEE, types_type <- "To see"))
                try self.database.run(types_table.insert(types_id <- DataBase.SEEN, types_type <- "Seen"))
                
            }
            
        }
        catch {
            print(error)
        }
        
        // ------------------------------------------------
    }
    
    
    
    public func insertMovie(movie:DiscoverMovieMDB, wichList:Int){
        
        let insertMovie = movies_table.insert(movies_id <- movie.id,movies_title <- movie.title!, movies_release_date <- movie.release_date!, movies_image_path <- movie.poster_path!)
        
        let insertMovieType = movies_types_table.insert( movies_types_id_movies <- movie.id, movies_types_id_types <- wichList  )
        
        do {
            print("INSERT MOVIE " + movie.title! + " INTO " + String(wichList))
            try self.database.run(insertMovie)
            try self.database.run(insertMovieType)
        } catch {
            print(error)
        }
        
    }
    
    public func removeMovie(movieId:Int){
        
        do{
            try database.transaction {
                let movieType = movies_types_table.filter(movies_types_id_movies ==  movieId)
                try database.run(movieType.delete())
                
                let movie = movies_table.filter(movies_id == movieId)
                try database.run(movie.delete())
            }
        }catch {
            print(error)
        }
        
    }
    
    public func updateMovieList(movieId:Int, newList:Int){
       
        do {
            let movieType = movies_types_table.filter(movies_types_id_movies ==  movieId)
            try database.run(movieType.update(movies_types_id_types <- newList))
        }catch{
            print(error)
        }
        
    }
    
    public func getMovies(wichList:Int) -> [Movie] {
        
        var movieArray: [Movie] = []
        
        let selectMovies = movies_table.join(movies_types_table, on: movies_id == movies_types_id_movies && movies_types_id_types == wichList)
    
        do {
            print("SELECT MOVIES FROM " + String(wichList))
            for movie in try database.prepare(selectMovies) {
                
                let m = Movie(movieId: movie[movies_id], movieTitle: movie[movies_title], movieReleaseDate: movie[movies_release_date], movieImagePath: movie[movies_image_path])
                
                movieArray.append(m)
            }
            
        }catch {
            print(error)
        }
        
        return movieArray
    }
    
}
