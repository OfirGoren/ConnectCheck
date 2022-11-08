//
//  UserDefaults.swift
//  InternetDisconnectionsApp
//
//  Created by Ofir Goren on 06/11/2022.
//

import Foundation
import UIKit

class LocalState {
    
    private enum keys:String {
        case hasAlreadyInitRows
    }
    

    
    public static var hasAlreadyInitRows: Bool {
        
        get {
            return UserDefaults.standard.bool(forKey: keys.hasAlreadyInitRows.rawValue)
            
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: keys.hasAlreadyInitRows.rawValue)
        }
        
    }
}
