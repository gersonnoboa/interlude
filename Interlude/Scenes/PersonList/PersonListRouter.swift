//
//  PersonListRouter.swift
//  Interlude
//
//  Created by Gerson Noboa on 02/11/2019.
//  Copyright © 2019 Heavenlapse. All rights reserved.
//

import UIKit

protocol PersonListRouterProtocol {
    func navigateToPersonDetails()
    func passDataToNextScene(using segue: UIStoryboardSegue)
}

final class PersonListRouter: PersonListRouterProtocol {
    weak var viewController: PersonListViewController?
    
    init(viewController: PersonListViewController?) {
        self.viewController = viewController
    }
    
    func navigateToPersonDetails() {
        viewController?.performSegue(withIdentifier: Segues.personListToPersonDetails, sender: nil)
    }
    
    func passDataToNextScene(using segue: UIStoryboardSegue) {
        if segue.identifier == Segues.personListToPersonDetails {
            passDataToPersonDetails(using: segue)
        }
    }
    
    private func passDataToPersonDetails(using segue: UIStoryboardSegue) {
        let source = segue.source as! PersonListViewController
        let destionation = segue.destination as! PersonDetailsViewController
        
        guard let selectedIndexPath = source.tableView.indexPathForSelectedRow,
            let interactor = source.interactor as? PersonListInteractor,
            let response = interactor.response?.personList[selectedIndexPath.row] else { return }
        
        let request = PersonDetails.Request(firstName: response.firstName,
                                            lastName: response.lastName,
                                            organizationName: response.organizationName,
                                            followers: response.followers,
                                            pictureURL: response.pictureURL)
        destionation.request = request
    }
}
