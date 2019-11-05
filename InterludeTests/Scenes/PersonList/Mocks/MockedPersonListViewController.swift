//
//  MockedPersonListViewController.swift
//  Interlude
//
//  Created by Gerson Noboa on 05/11/2019.
//  Copyright (c) 2019 Heavenlapse. All rights reserved.
//

@testable import Interlude

final class MockedPersonListViewController: PersonListViewController {
    var spy_showPersonListCalled = false
    
    override func showPersonList(using viewModel: PersonList.ViewModel) {
        spy_showPersonListCalled = true
        self.viewModel = viewModel
    }
}
