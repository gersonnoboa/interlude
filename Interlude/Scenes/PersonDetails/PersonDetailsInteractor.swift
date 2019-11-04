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
    var presenter: PersonDetailsPresenterProtocol
    var worker: PersonDetailsWorkerProtocol
    
    init(presenter: PersonDetailsPresenterProtocol, worker: PersonDetailsWorkerProtocol) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func requestPersonDetails(using request: PersonDetails.Request) {
        guard let response = worker.fetchPersonDetails(using: request) else { return }
        
        presenter.presentPersonDetails(using: response)
    }
}
