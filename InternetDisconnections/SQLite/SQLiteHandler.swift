//
//  SQLiteHandler.swift
//  InternetDisconnectionsApp
//
//  Created by Ofir Goren on 06/11/2022.
//

import Foundation
import SQLite
import SQLite3
class SQLiteHandler {
    
    enum Time:Int {
        case is00 = 00
        case is01 = 01
        case is02 = 02
        case is03 = 03
        case is04 = 04
        case is05 = 05
        case is06 = 06
        case is07 = 07
        case is08 = 08
        case is09 = 09
        case is10 = 10
        case is11 = 11
        case is12 = 12
        case is13 = 13
        case is14 = 14
        case is15 = 15
        case is16 = 16
        case is17 = 17
        case is18 = 18
        case is19 = 19
        case is20 = 20
        case is21 = 21
        case is22 = 22
        case is23 = 23
    }
    
    
    struct ViewModel {
        let time:Int
        let amount:Int
        
    }
    
    private let dataBaseConnectionError = "couldn't connect to dataBase"
    private let tableAlreadyExists = "table already Exists"
    private let insertRowFailed = "Insert row failed"
    private let getDataFailed = "get data Failed"
    
    private let table = Table("internetDisconnections")
    private let id = Expression<Int>("id")
    private let time = Expression<Int>("time")
    private let amount = Expression<Int>("amount")
    
    
    
    
    
    
    func createTable()  {
        
        
        // check connection to dataBase
        guard let dataBase = SQLiteDataBase.shardInstance.dataBase else {
            print(dataBaseConnectionError)
            return
            
        }
        // create table
        do {
            try dataBase.run(table.create(ifNotExists: true, block: {table in
                table.column(id, primaryKey: true)
                table.column(time)
                table.column(amount)
                
            }))
        }catch {
            print("\(tableAlreadyExists)\n\(error)")
            
        }
    }
    
    
    /// init Rows only once , when app first lanch
    func initRows() async  {
        
        if(LocalState.hasAlreadyInitRows == false) {
            
            // check connection to dataBase
            guard let dataBase = SQLiteDataBase.shardInstance.dataBase else {
                print(dataBaseConnectionError)
                return
            }
            do {
                for num in 0..<24 {
                    
                    try dataBase.run(table.insert(time <- num , amount <- 0))
                    print("0")
                }
                
                LocalState.hasAlreadyInitRows = true
            }catch {
                print(error)
            }
            
        }else {
            
        }
    }
    
    
    
    func insertRow(viewModel:ViewModel)-> Bool? {
        var isInsertWork = false
        
        // check connection to dataBase
        guard let dataBase = SQLiteDataBase.shardInstance.dataBase else {
            print(dataBaseConnectionError)
            return isInsertWork
        }
        do {
            try dataBase.run(table.insert(time <- viewModel.time
                                          , amount <- viewModel.amount))
            isInsertWork = true
            
        }catch let Result.error(message, code, statement) where code == SQLITE_CONSTRAINT {
            print("\(insertRowFailed)\n \(message) , in \(String(describing:statement))")
            
        }
        catch  {
            print("insertRowFailed\(error)")
        }
        return isInsertWork
    }
    
    
    
    func getRows() async  -> [ViewModel]? {
        
        var viewModel = [ViewModel]()
        
        // check connection to dataBase
        guard let dataBase = SQLiteDataBase.shardInstance.dataBase else {
            print(dataBaseConnectionError)
            return nil
        }
        do{
            let table = table.order(time.asc)
            for row in try dataBase.prepare(table) {
                
                let time = row[time]
                let amount = row[amount]
                viewModel.append(ViewModel(time: time, amount: amount))
            }
            
        }catch {
            print("\(getDataFailed): \(error)"  )
        }
        
        return viewModel
    }
    
    
    
    func increaseAmountValueByOne(column:Time) {
        
        let mtable = table.filter(time == column.rawValue)
        
        
        // check connection to dataBase
        guard let dataBase = SQLiteDataBase.shardInstance.dataBase else {
            print(dataBaseConnectionError)
            return
        }
        
        do {
            // here the problem
            try dataBase.run(mtable.update(amount += 1))
            
            
        }catch {
            print( "increase - > \(error)")
            
        }
        
    }
    
    
    func updateAccordingDisconnections() {
        
        
        let hour = Date().getCurrentHour()
        NWPathMonitorHandler().startCheckingNetwork { internetResult in
            if(!internetResult) {
                
                guard let hour = SQLiteHandler.Time(rawValue: hour) else{ return}
                
                self.increaseAmountValueByOne(column: hour)
            }
        }
        
    }
    
    func deleteAll() async {
        
            // check connection to dataBase
            guard let dataBase = SQLiteDataBase.shardInstance.dataBase else {
                print(dataBaseConnectionError)
                return
            }
            
            do {
                
                try dataBase.run("DELETE FROM internetDisconnections")
                
            }catch {
                print(error)
            }
            
        
    }
    
}
