//
//  PeopleListInteractor.swift
//  Interlude
//
//  Created by Gerson Noboa on 02/11/2019.
//  Copyright © 2019 Heavenlapse. All rights reserved.
//

import Foundation

protocol PersonListInteractorProtocol {
    func requestPersonList(using request: PersonList.Request)
}

final class PersonListInteractor: PersonListInteractorProtocol {
    var presenter: PersonListPresenterProtocol
    var worker: PersonListWorkerProtocol
    
    init(presenter: PersonListPresenterProtocol, worker: PersonListWorkerProtocol) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func requestPersonList(using request: PersonList.Request) {
        worker.fetchPersonList(using: request) { [weak self] list in
            guard let list = list else {
                self?.presenter.presentError()
                return
            }
            
            self?.presenter.presentPersonList(using: list)
        }
    }
}
