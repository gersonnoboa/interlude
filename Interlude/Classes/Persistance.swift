//
//  Persistance.swift
//  Interlude
//
//  Created by Gerson Noboa on 04/11/2019.
//  Copyright © 2019 Heavenlapse. All rights reserved.
//

import Foundation

class Persistance {
    static private let listUserDefaultsKey = "listUserDefaultsKey"
    
    static func tryListLoad(using userDefaults: UserDefaults) -> PersonListRemote? {
        guard let data = userDefaults.data(forKey: listUserDefaultsKey) else { return nil }
        
        let list = try! NSKeyedUnarchiver.unarchivedObject(ofClass: PersonListRemote.self, from: data)
        
        return list
    }
    
    static func tryListSave(using list: PersonListRemote, userDefaults: UserDefaults) {
        guard let data = try? NSKeyedArchiver.archivedData(withRootObject: list,
                                                           requiringSecureCoding: false) else { return }
        
        userDefaults.set(data, forKey: listUserDefaultsKey)
    }
}
