//
//  BarChartDataHandler.swift
//  InternetDisconnectionsApp
//
//  Created by Ofir Goren on 08/11/2022.
//

import Foundation


class InternetDisDataHandler {
    
    private static let numOfHours = 24
    
   static func getDataToInternatDisconnectionsList(data:[SQLiteHandler.ViewModel]?) ->  [DisconnectionsCell.ViewModel] {
        
        var internetDisconnectionsList = [DisconnectionsCell.ViewModel]()
    
        guard let data = data else { return internetDisconnectionsList}
        
        for (index,value) in data.enumerated() {
            let time = index.formatHour()
            let viewModel = DisconnectionsCell.ViewModel(time:time, occurrences: "\(value.amount)")
            internetDisconnectionsList.append(viewModel)
        }
       
       if(internetDisconnectionsList.isEmpty) {
           internetDisconnectionsList =  insertDafualtsAmounts()
       }
        
        return internetDisconnectionsList
    }
    
    
    
    
    
    
    
    // when there isn't data
  private static func insertDafualtsAmounts() -> [DisconnectionsCell.ViewModel] {
        
        var internetDisconnectionsList = [DisconnectionsCell.ViewModel]()
        
            for num in 0..<numOfHours {
                
                let time = num.formatHour()
                let viewModel = DisconnectionsCell.ViewModel(time:time, occurrences: "\(0)")
                
                internetDisconnectionsList.append(viewModel)
            }
        
        return internetDisconnectionsList
    }
}




