//
//  PersonListViewControllerTests.swift
//  Interlude
//
//  Created by Gerson Noboa on 05/11/2019.
//  Copyright (c) 2019 Heavenlapse. All rights reserved.
//

import Quick
import Nimble
@testable import Interlude

final class PersonListViewControllerTests: QuickSpec {
    override func spec() {
        var viewController: PersonListViewController!
        var interactor: MockedPersonListInteractor!
        var tableView: UITableView!
        
        describe("View controller") {
            beforeEach {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                viewController = storyboard.instantiateViewController(withIdentifier: "PersonListViewController") as? PersonListViewController
                
                viewController.beginAppearanceTransition(true, animated: false)
                viewController.endAppearanceTransition()
                
                interactor = MockedPersonListInteractor()
                let request = PersonList.Request(isFromPullToRefresh: false)
                interactor.requestPersonList(using: request)
            }
            
            context("On load") {
                it("should call the interactor") {
                    expect(interactor.spy_fetchPersonListCalled).to(beTrue())
                }
            }
            
            context("Table view") {
                beforeEach {
                    viewController.showPersonList(using: MockedPersonListModels.personListViewModel)
                    
                    tableView = viewController.tableView
                }
                
                it("should have one row") {
                    expect(viewController.tableView(tableView, numberOfRowsInSection: 0)).to(equal(1))
                }
                
                it("should have a cell of the correct type") {
                    let cell = viewController.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
                    
                    expect(cell).to(beAKindOf(PersonListCell.self))
                }
                
                it("should have the correct name") {
                    let cell = viewController.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! PersonListCell
                    
                    expect(cell.nameLabel.text).to(equal("Gerson Noboa"))
                }
                
                it("should have the correct organization name") {
                    let cell = viewController.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! PersonListCell
                    
                    expect(cell.organizationLabel.text).to(equal("Pipedrive"))
                }
                
                it("should have the correct follower count") {
                    let cell = viewController.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! PersonListCell
                    
                    expect(cell.followersLabel.text).to(equal("2010"))
                }
                
                it("should call the correct method in the router") {
                    let router = MockedPersonListRouter()
                    viewController.router = router
                    
                    viewController.tableView(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
                    
                    expect(router.spy_navigateToPersonDetailsCalled).to(beTrue())
                }
            }
        }
    }
}
