//
//  MockedPersonListInteractor.swift
//  Interlude
//
//  Created by Gerson Noboa on 05/11/2019.
//  Copyright (c) 2019 Heavenlapse. All rights reserved.
//

@testable import Interlude

final class MockedPersonListInteractor: PersonListInteractorProtocol {
    var spy_fetchPersonListCalled = false
    var request: PersonList.Request?
    
    func requestPersonList(using request: PersonList.Request) {
        spy_fetchPersonListCalled = true
        self.request = request
    }
}
