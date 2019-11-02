//
//  PersonListPresenter.swift
//  Interlude
//
//  Created by Gerson Noboa on 02/11/2019.
//  Copyright © 2019 Heavenlapse. All rights reserved.
//

import Foundation

protocol PersonListPresenterProtocol {
    func presentPersonList(using response: PersonList.Response)
    func presentError()
}

final class PersonListPresenter: PersonListPresenterProtocol {
    weak var viewController: PersonListViewControllerProtocol?
    
    init(viewController: PersonListViewControllerProtocol?) {
        self.viewController = viewController
    }
    
    func presentPersonList(using response: PersonList.Response) {
        print("response from presenter")
        print(response)
    }
    
    func presentError() {
        print("response error")
    }
}
