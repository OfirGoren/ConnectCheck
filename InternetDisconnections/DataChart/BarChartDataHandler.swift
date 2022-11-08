//
//  BarChartDataHandler.swift
//  InternetDisconnectionsApp
//
//  Created by Ofir Goren on 08/11/2022.
//

import Foundation
class BarChartDataHadler {
    
    private static let numOfHours = 24
    
   static func getBarChartData(data:[SQLiteHandler.ViewModel]?)->[BarChart.ViewModel] {
    
        var dataList = [BarChart.ViewModel]()
        guard let data = data else {return dataList}
     
        for data in data {
            let barChartViewModel = BarChart.ViewModel(y: Double(data.amount))
            dataList.append(barChartViewModel)
            
        }
   
        if(dataList.isEmpty) {
           dataList =  reloadDefaultBarChartData()
        }
        
      return dataList
    }
    
    
  private static  func reloadDefaultBarChartData()-> [BarChart.ViewModel] {
        
            var dataList = [BarChart.ViewModel]()
            
            for _ in 0..<numOfHours {
                let barChartViewModel = BarChart.ViewModel(y: Double(0))
                dataList.append(barChartViewModel)
                
            }
            return dataList
        }
    }

