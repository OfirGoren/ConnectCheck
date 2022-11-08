//
//  NetworkingHandler.swift
//  InternetDisconnectionsApp
//
//  Created by Ofir Goren on 07/11/2022.
//

import Foundation
import Network


class NWPathMonitorHandler {
    let monitor = NWPathMonitor()
    
    
    
    func startCheckingNetwork(completionHandler: @escaping (Bool)->Void)  {
        
        monitor.pathUpdateHandler = { path in
           
            if path.status == .satisfied {
                completionHandler(true)
                print("We're connected!")
            } else {
                completionHandler(false)
                print("No connection.")
            }
            
            print(path.isExpensive)
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        
        
        
    }
    
    
    
}



