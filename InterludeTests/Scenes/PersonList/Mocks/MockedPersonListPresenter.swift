//
//  MockedPersonListPresenter.swift
//  Interlude
//
//  Created by Gerson Noboa on 05/11/2019.
//  Copyright (c) 2019 Heavenlapse. All rights reserved.
//

@testable import Interlude

final class MockedPersonListPresenter: PersonListPresenterProtocol {
    var spy_presentPersonListCalled = false
    var spy_presentErrorCalled = false
    var spy_presentLoadingCalled = false
    var spy_hideLoadingCalled = false
    var isFromPullToRefresh = false
    var response: PersonList.Response?
    
    func presentPersonList(using response: PersonList.Response) {
        spy_presentPersonListCalled = true
        self.response = response
    }
    
    func presentError() {
        spy_presentErrorCalled = true
    }
    
    func presentLoading(isFromPullToRefresh: Bool) {
        spy_presentLoadingCalled = true
        self.isFromPullToRefresh = isFromPullToRefresh
    }
    
    func hideLoading(isFromPullToRefresh: Bool) {
        spy_hideLoadingCalled = true
        self.isFromPullToRefresh = isFromPullToRefresh
    }
}
