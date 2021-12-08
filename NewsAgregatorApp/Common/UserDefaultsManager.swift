//
//  DataBaseManager.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 08.12.2021.
//

import UIKit

enum UserDefaultsKey: String, CaseIterable {
    case settingsModel
}

protocol UserDefaultsManagerProtocol {
    var userDefaults: UserDefaults { get }
    func saveValue(forKey key: UserDefaultsKey, value: Any)
    func readValue<T>(forKey key: UserDefaultsKey) -> T?
    func decodeValue<T: Decodable>(forKey key: UserDefaultsKey) -> T?
    func encodeValue<T: Encodable>(forKey key: UserDefaultsKey, value: T)
}

extension UserDefaultsManagerProtocol {

    func saveValue(forKey key: UserDefaultsKey, value: Any) {
        self.userDefaults.set(value, forKey: key.rawValue)
    }
    
    func readValue<T>(forKey key: UserDefaultsKey) -> T? {
        return userDefaults.value(forKey: key.rawValue) as? T
    }
    
    func decodeValue<T:Decodable>(forKey key: UserDefaultsKey) -> T? {
        if let data = self.userDefaults.data(forKey: key.rawValue) {
            return try? PropertyListDecoder().decode(T.self, from: data)
        }
        return nil
    }
    
    func encodeValue<T: Encodable>(forKey key: UserDefaultsKey, value: T) {
        if let data = try? PropertyListEncoder().encode(value) {
            UserDefaults.standard.set(data, forKey: key.rawValue)
        }
    }
}

class UserDefaultsManager: UserDefaultsManagerProtocol {

    var userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
}
