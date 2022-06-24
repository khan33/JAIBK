//
//  UserDefaults+Extension.swift
//  JAIBK
//
//  Created by Atta khan on 27/05/2022.
//

import Foundation

extension UserDefaults {
    
    static func getSavedValue<T>(key: UserDefaultsKey) -> T {
        let decoded = UserDefaults.standard.object(forKey: key.rawValue) as! Data
        return (NSKeyedUnarchiver.unarchiveObject(with: decoded) as! T)
    }
    
    static func setSavedValue<T>(value: T, key: UserDefaultsKey) {
        let userEncodedData: Data = NSKeyedArchiver.archivedData(withRootObject: value)
        UserDefaults.standard.set(userEncodedData, forKey: key.rawValue)
    }
    
    static func removeAllKeysValues() {
        let sessionID = AppUtils.shared.sessionID

        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
        
        AppUtils.shared.sessionID = sessionID
    }
    
    static func removeSpecificKeysValues(key: UserDefaultsKey) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key.rawValue)
    }
    
    static func containsKey(key: UserDefaultsKey) -> Bool {
        return UserDefaults.standard.object(forKey: key.rawValue) != nil
    }
}
