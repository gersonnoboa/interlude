//
//  PersonListWorker.swift
//  Interlude
//
//  Created by Gerson Noboa on 02/11/2019.
//  Copyright © 2019 Heavenlapse. All rights reserved.
//

import Foundation

protocol PersonListWorkerProtocol {
    func fetchPersonList(using request: PersonList.Request, completion: @escaping (PersonList.Response?) -> Void)
}

final class PersonListWorker: PersonListWorkerProtocol {
    var network: Network
    var userDefaults: UserDefaults
    
    init(network: Network = Network.shared, userDefaults: UserDefaults = UserDefaults.standard) {
        self.network = network
        self.userDefaults = userDefaults
    }
    
    func fetchPersonList(using request: PersonList.Request, completion: @escaping (PersonList.Response?) -> Void) {
        if let persistanceList = tryPersistanceLoad(), !request.isFromPullToRefresh, false {
            print("load from persistance")
            completeOperation(using: persistanceList, completion: completion)
        } else {
            print("load from network")
            network.getJSON(Links.personList) { [weak self] (list: PersonListRemote?) in
                self?.completeOperation(using: list, completion: completion)
            }
        }
    }
    
    private func completeOperation(using list: PersonListRemote?, completion: @escaping (PersonList.Response?) -> Void) {
        guard let list = list, list.success else {
            completion(nil)
            return
        }
        
        let personList = list.data.map { Person.Response(id: $0.id,
                                                                firstName: $0.firstName,
                                                                lastName: $0.lastName,
                                                                organizationName: $0.orgName,
                                                                followers: $0.followersCount)}
        
        let response = PersonList.Response(personList: personList)
        completion(response)
        tryPersistanceSave(using: list)
    }
    
    private func tryPersistanceSave(using list: PersonListRemote) {
        guard let data = try? NSKeyedArchiver.archivedData(withRootObject: list,
                                                           requiringSecureCoding: false) else { return }
        
        userDefaults.set(data, forKey: Constants.listUserDefaultsKey)
    }
    
    private func tryPersistanceLoad() -> PersonListRemote? {
        guard let data = userDefaults.data(forKey: Constants.listUserDefaultsKey) else { return nil }
        
        let list = try! NSKeyedUnarchiver.unarchivedObject(ofClass: PersonListRemote.self, from: data)
        
        return list
    }
}
