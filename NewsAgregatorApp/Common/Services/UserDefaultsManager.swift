//
//  DataBaseManager.swift
//  NewsAgregatorApp
//
//  Created by Лилия Левина on 08.12.2021.
//

import UIKit

enum UserDefaultsKey: String, CaseIterable {
    case settingsModel
    case readMarks
}

protocol UserDefaultsManagerProtocol {
    var userDefaults: UserDefaults { get }
    func readValue<T>(forKey key: UserDefaultsKey) -> T?
    func readValue<T: Decodable>(type: T.Type, forKey key: UserDefaultsKey) -> T?
    func saveValue(forKey key: UserDefaultsKey, value: Any)
    func archiveValue<T: Encodable>(forKey key: UserDefaultsKey, value: T)
    func removeUserInfo()
}

extension UserDefaultsManagerProtocol {
    
    func saveValue(forKey key: UserDefaultsKey, value: Any) {
        self.userDefaults.set(value, forKey: key.rawValue)
    }
    
    func readValue<T>(forKey key: UserDefaultsKey) -> T? {
        return userDefaults.value(forKey: key.rawValue) as? T
    }
    
    func decodeValue<T: Decodable>(forKey key: UserDefaultsKey) -> T? {
        guard let data = self.userDefaults.data(forKey: key.rawValue) else { return nil
        }
        let decoder = JSONDecoder()
        return try? decoder.decode(T.self, from: data)
    }
    
    func archiveValue<T: Encodable>(forKey key: UserDefaultsKey, value: T) {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(value) else { return }
        UserDefaults.standard.set(data, forKey: key.rawValue)
    }
    
    func readValue<T: Decodable>(type: T.Type, forKey key: UserDefaultsKey) -> T?
    {
        let decoder = JSONDecoder()
        if let data = self.userDefaults.object(forKey: key.rawValue) as? Data,
           let object = try? decoder.decode(T.self, from: data) {
            return object
        }
        return nil
    }
    
    func removeUserInfo() {
        UserDefaultsKey
            .allCases
            .map { $0.rawValue }
            .forEach { key in
                userDefaults.removeObject(forKey: key)
            }
    }
}

class UserDefaultsManager: UserDefaultsManagerProtocol {
    
    var userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
}
