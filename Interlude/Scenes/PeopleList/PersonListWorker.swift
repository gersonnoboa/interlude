//
//  PersonListWorker.swift
//  Interlude
//
//  Created by Gerson Noboa on 02/11/2019.
//  Copyright © 2019 Heavenlapse. All rights reserved.
//

import Foundation

protocol PersonListWorkerProtocol {
    func fetchPersonList(using request: PersonList.Request, completion: () -> Void)
}

final class PersonListWorker: PersonListWorkerProtocol {
    func fetchPersonList(using request: PersonList.Request, completion: () -> Void) {
        
    }
}
