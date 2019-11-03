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
    var response: PersonList.Response?
    
    init(presenter: PersonListPresenterProtocol, worker: PersonListWorkerProtocol) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func requestPersonList(using request: PersonList.Request) {
        presenter.presentRefreshControlLoadingState()
        
        worker.fetchPersonList(using: request) { [weak self] list in
            self?.response = list
            
            guard let list = list else {
                self?.presenter.presentError()
                self?.presenter.presentRefreshControlInitialState()
                
                return
            }
            
            self?.presenter.presentPersonList(using: list)
            self?.presenter.presentRefreshControlInitialState()
        }
    }
}
