//
//  PersonDetailsPresenter.swift
//  Interlude
//
//  Created by Gerson Noboa on 03/11/2019.
//  Copyright © 2019 Heavenlapse. All rights reserved.
//

import Foundation

protocol PersonDetailsPresenterProtocol {
    func presentPersonDetails(using response: PersonDetails.Response)
}

final class PersonDetailsPresenter: PersonDetailsPresenterProtocol {
    weak var viewController: PersonDetailsViewControllerProtocol?
    
    init(viewController: PersonDetailsViewControllerProtocol?) {
        self.viewController = viewController
    }
    
    func presentPersonDetails(using response: PersonDetails.Response) {
        let viewModel = PersonDetails.ViewModel(firstName: response.firstName,
                                                lastName: response.lastName,
                                                organizationName: response.organizationName,
                                                followers: "\(response.followers)")
        
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.showPersonDetails(using: viewModel)
        }
    }
}
