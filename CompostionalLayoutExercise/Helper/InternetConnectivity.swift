//
//  InternetConnectivity.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 14/09/22.
//

import Network

final class InternetConnectivity {
    //MARK: - Private Variable
    private let queue = DispatchQueue(label: "com.internetStatus")
    private let monitor : NWPathMonitor?
    static let shared = InternetConnectivity()
    
    
  public private(set) var isConnectionStable = false
    
    private init(){
        monitor = NWPathMonitor()
    }
    
    public func monitorConnectionStatus(){
        let monitor = NWPathMonitor()
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { path in
            self.isConnectionStable = path.status == .satisfied
        }
        
    }
}
