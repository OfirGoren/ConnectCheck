//
//  Date.swift
//  InternetDisconnectionsApp
//
//  Created by Ofir Goren on 06/11/2022.
//

import Foundation

extension Date {
    
    
    func getCurrentHour()->Int {
        
     return Calendar.current.component(.hour, from: self)
    }
    
    
    
    
}
