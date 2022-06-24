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
    case wishIds = "wishIds"
    case language = "language"
    case likeIds = "likeIds"
    case session = "sesssionId"
}

class AppUtils{
    
    static let shared = AppUtils()
    
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    
    var token: String{
        get{
            return UserDefaults.getSavedValue(key: .token) ?? ""
        }
    }
    
    func saveToken(token: String){
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
    
//    var wishList: [Product]?{
//        get{
//            if UserDefaults.containsKey(key: .wishIds){
//                if let data = UserDefaults.standard.object(forKey: UserDefaultsKey.wishIds.rawValue) as? Data{
//                    if let ids = try? decoder.decode(Array<Product>.self, from: data){
//                        return ids
//                    }
//                }
//            }
//            return []
//        }
//    }
//    var likeList: [YouMightLike]?{
//        get{
//            if UserDefaults.containsKey(key: .likeIds){
//                if let data = UserDefaults.standard.object(forKey: UserDefaultsKey.likeIds.rawValue) as? Data{
//                    if let ids = try? decoder.decode(Array<YouMightLike>.self, from: data){
//                        return ids
//                    }
//                }
//            }
//            return []
//        }
//    }
//    var cartcount: Int {
//        get {
//            let value = UserDefaults.standard.integer(forKey: "cartcount")
//            return value
//        } set {
//            UserDefaults.standard.set(newValue, forKey: "cartcount")
//            NotificationCenter.default.post(name: .updateTabBarBadge, object: nil)
//        }
//    }
//
//    var language: String{
//        get{
//            if UserDefaults.containsKey(key: .loginUser){
//                return UserDefaults.getSavedValue(key: .language) ?? ""
//            }
//            return "1"
//        }
//    }
    

    

//
    
    
    
    

//
//    func saveFavorits(ids: [YouMightLike]){
//        if let data = try? encoder.encode(ids) {
//            UserDefaults.standard.setValue(data, forKey: UserDefaultsKey.likeIds.rawValue)
//        }
//    }
}
