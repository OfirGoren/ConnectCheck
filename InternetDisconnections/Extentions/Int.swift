//
//  Int.swift
//  InternetDisconnectionsApp
//
//  Created by Ofir Goren on 07/11/2022.
//

import Foundation

extension Int {
    
    
    /// Get number and return hour
    /// Exemples:
    /// Input -> 2 , output -> 02
    /// Input -> 22, output -> 22
    func formatHour()->String {
        var time = ""
        if(self <= 9) {
            time = "0\(self):00"
        }else {
            time = "\(self):00"
        }
        return time
    }
    
    
}
