//
//  SQLiteManager.swift
//  InternetDisconnectionsApp
//
//  Created by Ofir Goren on 04/11/2022.
//

import Foundation
import SQLite3
import SQLite

final class SQLiteDataBase{
    
    static let shardInstance = SQLiteDataBase(dataBaseName: "intenetDisconnectionsList")
    
    var dataBase:Connection? = nil
    private let errorToOpenDataBase = "can't open SQLite DataBase"
    private let creatingConnectionError = "Creating connection to dataBase error:\n"
    
    private init(dataBaseName:String) {
        openConntection(dataBaseName: dataBaseName)
    }
    
    
    func openConntection(dataBaseName:String) {

        do {
            let doucumentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                
            let fileUrl = doucumentDirectory.appendingPathComponent(dataBaseName)
                .appendingPathExtension("sqlite3")
         
            dataBase = try Connection(fileUrl.path)
            
    }catch {
            print("\(creatingConnectionError)\(error)")
            
        }
        
    }
    
    
   
}
