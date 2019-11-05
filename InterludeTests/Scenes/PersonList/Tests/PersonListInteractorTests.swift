//
//  PersonListInteractorTests.swift
//  Interlude
//
//  Created by Gerson Noboa on 05/11/2019.
//  Copyright (c) 2019 Heavenlapse. All rights reserved.
//

import Quick
import Nimble
@testable import Interlude

final class PersonListInteractorTests: QuickSpec {
    override func spec() {
        var interactor: PersonListInteractor!
        var presenter: MockedPersonListPresenter!
        
        describe("Interactor") {
            context("On successful worker operation") {
                beforeEach {
                    let worker = MockedSuccessPersonListWorker()
                    setupTests(with: worker)
                }
                
                it("should trigger the correct method in the presenter") {
                    expect(presenter.spy_presentPersonListCalled).to(beTrue())
                }
                
                it("should trigger the hide loading method in the presenter") {
                    expect(presenter.spy_hideLoadingCalled).to(beTrue())
                }
                
                it("should trigger the hide loading method in the presenter without pull to refresh") {
                    expect(presenter.isFromPullToRefresh).to(beFalse())
                }
                
                it("should trigger the hide loading method in the presenter with pull to refresh when appropriate") {
                    let request = PersonList.Request(isFromPullToRefresh: true)
                    interactor.requestPersonList(using: request)
                    
                    expect(presenter.isFromPullToRefresh).to(beTrue())
                }
            }
            
            context("On failed worker operation") {
                beforeEach {
                    let worker = MockedErrorPersonListWorker()
                    setupTests(with: worker)
                }
                
                it("should trigger the correct method in the presenter") {
                    expect(presenter.spy_presentErrorCalled).to(beTrue())
                }
            }
        }
        
        func setupTests(with worker: PersonListWorkerProtocol) {
            presenter = MockedPersonListPresenter()
            interactor = PersonListInteractor(presenter: presenter, worker: worker)
            
            let request = PersonList.Request(isFromPullToRefresh: false)
            interactor.requestPersonList(using: request)
        }
    }
}
