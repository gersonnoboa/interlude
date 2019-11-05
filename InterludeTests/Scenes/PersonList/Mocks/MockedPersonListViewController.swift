//
//  MockedPersonListViewController.swift
//  Interlude
//
//  Created by Gerson Noboa on 05/11/2019.
//  Copyright (c) 2019 Heavenlapse. All rights reserved.
//

@testable import Interlude

final class MockedPersonListViewController: PersonListViewControllerProtocol {
    var spy_showPersonListCalled = false
    var spy_showRefreshControlUpdate = false
    var spy_showLoading = false
    var spy_hideLoading = false
    var spy_showError = false
    var viewModel: PersonList.ViewModel?
    var updateText: String?
    var shouldRefresh: Bool?
    
    func showPersonList(using viewModel: PersonList.ViewModel) {
        spy_showPersonListCalled = true
        self.viewModel = viewModel
    }
    
    func showRefreshControlUpdate(_ updateText: String, shouldRefresh: Bool) {
        spy_showRefreshControlUpdate = true
        self.updateText = updateText
        self.shouldRefresh = shouldRefresh
    }
    
    func showLoading() {
        spy_showLoading = true
    }
    
    func hideLoading() {
        spy_hideLoading = true
    }
    
    func showError() {
        spy_showError = true
    }
}
