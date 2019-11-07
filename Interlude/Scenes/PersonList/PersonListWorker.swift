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
        if let persistanceList = Persistance.tryListLoad(using: userDefaults), !request.isFromPullToRefresh {
            completeOperation(using: persistanceList, completion: completion)
        } else {
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
                                                                followers: $0.followersCount,
                                                                pictureURL: $0.pictureURL)}
        
        let response = PersonList.Response(personList: personList)
        completion(response)
        Persistance.tryListSave(using: list, userDefaults: userDefaults)
    }
}
