//
//  DataBase.swift
//  Filmder
//
//  Created by if26-grp3 on 18/12/2018.
//  Copyright © 2018 civetdelapin. All rights reserved.
//

import Foundation
import SQLite

class DataBase {
    
    
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
    let types_type = Expression<Int>("type")
    
    
    static func GetInstance()->DataBase{
    
        if(dataBaseInstance == nil){
            dataBaseInstance = DataBase()
        }
    
        return dataBaseInstance!
    }
    
    
    private init() {
        
        
        // ---- CREER DATABASE ICI (COPIER LE CODE DU PROF)
        
        
        // --------- CREATION DES BASES DE DONNEES ---------
        
        let createTableMovies = self.movies_table.create(ifNotExists: true) { table in
            table.column(self.movies_id, primaryKey : true)
            table.column(self.movies_title)
            table.column(self.movies_release_date)
            table.column(self.movies_image_path)
        }
        
        let createTableMoviesTypes = self.movies_types_table.create(ifNotExists: true){ table in
            table.column(self.movies_types_id_movies, primaryKey : true)
            table.column(self.movies_types_id_types, primaryKey : true)
        }
        
        let createTableTypes = self.types_table.create(ifNotExists : true){ table in
            table.column(self.types_id, primaryKey : true)
            table.column(self.types_type)
        }
        
        
        do {
            
            try self.database.run(createTableTypes)
            try self.database.run(createTableMovies)
            try self.database.run(createTableMoviesTypes)
            
        }
        catch {
            print(error)
        }

        // ------------------------------------------------
    }
    
    
}
