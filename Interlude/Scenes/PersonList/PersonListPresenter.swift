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
    func presentLoading(isFromPullToRefresh: Bool)
    func hideLoading(isFromPullToRefresh: Bool)
}

final class PersonListPresenter: PersonListPresenterProtocol {
    weak var viewController: PersonListViewControllerProtocol?
    
    init(viewController: PersonListViewControllerProtocol?) {
        self.viewController = viewController
    }
    
    func presentPersonList(using response: PersonList.Response) {
        
        let list = response.personList.map { person -> Person.ViewModel in
            let fullName = "\(person.firstName) \(person.lastName.uppercased())"
            let organizationName = "Part of \(person.organizationName)"
            let followerString = person.followers == 1 ? "follower" : "followers"
            let followers = "\(person.followers) \(followerString)"
            
            return Person.ViewModel(fullName: fullName,
                                           organizationName: organizationName,
                                           followers: followers)
        }
        
        let viewModel = PersonList.ViewModel(personList: list)
        
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.showPersonList(using: viewModel)
        }
    }
    
    func presentError() {
        
    }
    
    func presentLoading(isFromPullToRefresh: Bool) {
        DispatchQueue.main.async { [weak self] in
            isFromPullToRefresh ? self?.viewController?.showRefreshControlUpdate("Loading", shouldRefresh: true) :
                self?.viewController?.showLoading()
        }
    }
    
    func hideLoading(isFromPullToRefresh: Bool) {
        DispatchQueue.main.async { [weak self] in
            isFromPullToRefresh ? self?.viewController?.showRefreshControlUpdate("Pull to refresh", shouldRefresh: false) :
                self?.viewController?.hideLoading()
        }
    }
}
