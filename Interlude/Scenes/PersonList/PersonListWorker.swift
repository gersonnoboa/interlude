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
    
    init(network: Network = Network.shared) {
        self.network = network
    }
    
    func fetchPersonList(using request: PersonList.Request, completion: @escaping (PersonList.Response?) -> Void) {
        network.getJSON(Links.personList) { (list: PersonList.Remote?) in
            guard let list = list, list.success else {
                completion(nil)
                return
            }
            
            let personList = list.data.map { PersonDetails.Response(id: $0.id,
                                                               firstName: $0.firstName,
                                                               lastName: $0.lastName,
                                                               organizationName: $0.orgName)}
            
            let response = PersonList.Response(personList: personList)
            completion(response)
        }
    }
}
