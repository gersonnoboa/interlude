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
        let response = MockedPersonListModels.personListResponse
        completion(response)
    }
}

final class MockedErrorPersonListWorker: PersonListWorkerProtocol {
    func fetchPersonList(using request: PersonList.Request, completion: @escaping (PersonList.Response?) -> Void) {
        completion(nil)
    }
}
