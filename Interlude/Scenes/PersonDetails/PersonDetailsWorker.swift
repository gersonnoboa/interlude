//
//  PersonDetailsWorker.swift
//  Interlude
//
//  Created by Gerson Noboa on 04/11/2019.
//  Copyright © 2019 Heavenlapse. All rights reserved.
//

import Foundation

protocol PersonDetailsWorkerProtocol {
    func fetchPersonDetails(using request: PersonDetails.Request) -> PersonDetails.Response?
}

final class PersonDetailsWorker: PersonDetailsWorkerProtocol {
    var userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    func fetchPersonDetails(using request: PersonDetails.Request) -> PersonDetails.Response? {
        guard let list = Persistance.tryListLoad(using: userDefaults),
            list.success,
            let person = (list.data.first { $0.id == request.id }) else { return nil }
        
        return PersonDetails.Response(firstName: person.firstName,
                                      lastName: person.lastName,
                                      organizationName: person.orgName,
                                      followers: person.followersCount,
                                      pictureURL: person.pictureURL,
                                      openDealsCount: person.openDealsCount,
                                      closedDealsCount: person.closedDealsCount,
                                      isActive: person.isActive,
                                      lastUpdated: person.lastUpdated,
                                      email: person.email)
    }
}
