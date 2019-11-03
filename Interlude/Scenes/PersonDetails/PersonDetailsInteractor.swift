//
//  PersonDetailsInteractor.swift
//  Interlude
//
//  Created by Gerson Noboa on 03/11/2019.
//  Copyright © 2019 Heavenlapse. All rights reserved.
//

import Foundation

protocol PersonDetailsInteractorProtocol {
    func requestPersonDetails(using request: PersonDetails.Request)
}

final class PersonDetailsInteractor: PersonDetailsInteractorProtocol {
    var presenter: PersonDetailsPresenterProtocol?
    
    init(presenter: PersonDetailsPresenterProtocol) {
        self.presenter = presenter
    }
    
    func requestPersonDetails(using request: PersonDetails.Request) {
        let response = PersonDetails.Response(firstName: request.firstName,
                                              lastName: request.lastName,
                                              organizationName: request.organizationName,
                                              followers: request.followers)
        presenter?.presentPersonDetails(using: response)
    }
}
