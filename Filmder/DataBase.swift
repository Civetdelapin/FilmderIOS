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
            table.column(self.types_id, primaryKey : true)
            table.column(self.types_id, primaryKey : .autoincrement)
            
            table.column(self.types_type)
        }
        
        let createTableMoviesTypes = self.movies_types_table.create(ifNotExists: true){ table in
            table.column(self.movies_types_id_movies, primaryKey : true)
            table.column(self.movies_types_id_types, primaryKey : true)
            
            table.foreignKey(self.movies_types_id_movies, references: movies_table, self.movies_id)
            table.foreignKey(self.movies_types_id_types, references: types_table, self.types_id)
        }
        
        
        do {
            
            try self.database.run(createTableTypes)
            try self.database.run(createTableMovies)
            try self.database.run(createTableMoviesTypes)

            let tableTypesCount = try database.scalar(types_table.count);
            if(tableTypesCount == 0){
                
                try self.database.run(types_table.insert(types_type <- "Archived"))
                try self.database.run(types_table.insert(types_type <- "To see"))
                try self.database.run(types_table.insert(types_type <- "Seen"))
                
            }
            
            
        }
        catch {
            print(error)
        }

        
        
        // ------------------------------------------------
    }
    
    
}
