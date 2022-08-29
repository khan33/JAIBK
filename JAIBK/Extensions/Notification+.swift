//
//  Notification+.swift
//  JAIBK
//
//  Created by Atta khan on 10/08/2022.
//

import Foundation



extension NotificationCenter{
    
    static func register(name: Notification.Name, completionHandler: @escaping (Notification)->Void){
        self.default.addObserver(forName: name, object: nil, queue: .main, using: completionHandler)
    }
    
    static func dispatch(name: Notification.Name, payload:[AnyHashable : Any]? = nil){
        self.default.post(name: name, object: nil, userInfo: payload)
    }
}


extension Notification.Name{
    static var sideMenuListener: Notification.Name {
        return .init(rawValue: "sideMenuListener")
    }
    
    
    static var updateTabBarBadge: Notification.Name {
        return .init(rawValue: "updateTabBarBadge")
    }
}
