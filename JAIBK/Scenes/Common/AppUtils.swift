//
//  AppUtils.swift
//  JAIBK
//
//  Created by Atta khan on 27/05/2022.
//

import Foundation

public enum UserDefaultsKey : String{
    case loginUser = "loginUser"
    case token = "token"
    case session = "sesssionId"
}

class AppUtils{
    
    static let shared = AppUtils()
    
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    
    var token: String {
        get {
            return UserDefaults.getSavedValue(key: .token) ?? ""
        }
    }
    
    func saveToken(token: String) {
        UserDefaults.setSavedValue(value: "Bearer \(token)", key: .token)
    }
    
    
    var sessionID: String? {
        get {
            return UserDefaults.getSavedValue(key: .session)
        } set {
            UserDefaults.setSavedValue(value: newValue, key: .session)
        }
    }
    
    func saveUser(user: UserData){
        if let encodedData = try? encoder.encode(user){
            UserDefaults.setSavedValue(value: encodedData, key: .loginUser)
        }
    }
    
    
    var loginUser: UserData?{
        get{
            if UserDefaults.containsKey(key: .loginUser){
                if let data : Data = UserDefaults.getSavedValue(key: .loginUser){
                    if let user = try? decoder.decode(UserData.self, from: data){
                        return user
                    }
                }
            }
            return nil
        }
    }
    
    
    func clearSession(){
        UserDefaults.removeAllKeysValues()
    }
}
