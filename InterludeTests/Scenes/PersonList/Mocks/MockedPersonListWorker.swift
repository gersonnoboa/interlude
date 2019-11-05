//
//  MockedPersonListWorker.swift
//  InterludeTests
//
//  Created by Gerson Noboa on 05/11/2019.
//  Copyright © 2019 Heavenlapse. All rights reserved.
//

@testable import Interlude

final class MockedSuccessPersonListWorker: PersonListWorkerProtocol {
    func fetchPersonList(using request: PersonList.Request, completion: @escaping (PersonList.Response?) -> Void) {
        let person = Person.Response(id: 1, firstName: "Gerson", lastName: "Noboa", organizationName: "Pipedrive", followers: 2010, pictureURL: "https://cms.pipedriveassets.com/Bootcamp-July-group.jpg")
        let response = PersonList.Response(personList: [person])
        
        completion(response)
    }
}

final class MockedErrorPersonListWorker: PersonListWorkerProtocol {
    func fetchPersonList(using request: PersonList.Request, completion: @escaping (PersonList.Response?) -> Void) {
        completion(nil)
    }
}
