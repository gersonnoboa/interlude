//
//  PersonListPresenterTests.swift
//  Interlude
//
//  Created by Gerson Noboa on 05/11/2019.
//  Copyright (c) 2019 Heavenlapse. All rights reserved.
//

import Quick
import Nimble
@testable import Interlude

final class PersonListPresenterTests: QuickSpec {
    override func spec() {
        var presenter: PersonListPresenter!
        var viewController: MockedPersonListViewController!
        
        describe("Presenter") {
            context("On success") {
                beforeEach {
                    viewController = MockedPersonListViewController()
                    presenter = PersonListPresenter(viewController: viewController)
                    
                    let list = MockedPersonListModels.personListResponse
                    presenter.presentPersonList(using: list)
                }
                
                it("should trigger the correct method in the view controller") {
                    expect(viewController.spy_showPersonListCalled).toEventually(beTrue())
                }
                
                it("should have a valid person list") {
                    expect(viewController.viewModel).toNotEventually(beNil())
                }
                
                it("should have a person list with one person") {
                    expect(viewController.viewModel?.personList).toEventually(haveCount(1))
                }
                
                it("should have the correct full name") {
                    expect(viewController.viewModel?.personList.first?.fullName).toEventually(equal("Gerson NOBOA"))
                }
                
                it("should have the correct organization name") {
                    expect(viewController.viewModel?.personList.first?.organizationName).toEventually(equal("Part of Pipedrive"))
                }
                
                it("should have the correct number of followers") {
                    expect(viewController.viewModel?.personList.first?.followers).toEventually(equal("2010 followers"))
                }
                
                it("should have the correct singular number of followers") {
                    var list = MockedPersonListModels.personListResponse
                    list.personList[0].followers = 1
                    presenter.presentPersonList(using: list)
                    
                    expect(viewController.viewModel?.personList.first?.followers).toEventually(equal("1 follower"))
                }
            }
            
            context("On showing loading") {
                beforeEach {
                    viewController = MockedPersonListViewController()
                    presenter = PersonListPresenter(viewController: viewController)
                    
                    presenter.presentLoading(isFromPullToRefresh: false)
                }
                
                it("should show the loading only if the request doesn't come from pull to refresh") {
                    expect(viewController.spy_showLoading).toEventually(beTrue())
                }
            }
            
            context("On hide loading") {
                beforeEach {
                    viewController = MockedPersonListViewController()
                    presenter = PersonListPresenter(viewController: viewController)
                    
                    presenter.hideLoading(isFromPullToRefresh: false)
                }
                
                it("should hide the loading") {
                    expect(viewController.spy_hideLoading).toEventually(beTrue())
                }
            }
            
            context("Refresh control appearance") {
                beforeEach {
                    viewController = MockedPersonListViewController()
                    presenter = PersonListPresenter(viewController: viewController)
                    
                    presenter.presentLoading(isFromPullToRefresh: true)
                }
                
                it("should trigger the refresh control method") {
                    expect(viewController.spy_showRefreshControlUpdate).toEventually(beTrue())
                }
                
                it("should be refreshing the refresh control") {
                    expect(viewController.shouldRefresh).toEventually(beTrue())
                }
            }
            
            context("Refresh control dismissal") {
                beforeEach {
                    viewController = MockedPersonListViewController()
                    presenter = PersonListPresenter(viewController: viewController)
                    
                    presenter.hideLoading(isFromPullToRefresh: true)
                }
                
                it("should trigger the refresh control method") {
                    expect(viewController.spy_showRefreshControlUpdate).toEventually(beTrue())
                }
                
                it("should be refreshing the refresh control") {
                    expect(viewController.shouldRefresh).toEventually(beFalse())
                }
            }
            
            context("On error") {
                beforeEach {
                    viewController = MockedPersonListViewController()
                    presenter = PersonListPresenter(viewController: viewController)
                    
                    presenter.presentError()
                }
                
                it("should show the error") {
                    expect(viewController.spy_showError).toEventually(beTrue())
                }
            }
        }
    }
}
