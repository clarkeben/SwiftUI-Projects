//
//  NetworkMonitor.swift
//  Chat AI
//
//  Created by Ben Clarke on 23/03/2023.
//

import Foundation
import Network

struct NetworkMonitorManager {
    static let shared = NetworkMonitorManager()
    
    let monitor = NWPathMonitor()
    
    func startMonitoring(completion: @escaping (Bool) -> Void) {
        monitor.start(queue: DispatchQueue.global())
        
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                if path.status == .satisfied || path.status == .unsatisfied {
                    if !path.usesInterfaceType(.wifi) && !path.usesInterfaceType(.cellular) {
                        completion(false)
                    } else {
                        completion(true)
                    }
                }
            }
        }
    }
}
