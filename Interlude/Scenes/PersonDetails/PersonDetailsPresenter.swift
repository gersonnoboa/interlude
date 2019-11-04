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
        let fullName = "\(response.firstName) \(response.lastName.uppercased())"
        let viewModel = PersonDetails.ViewModel(fullName: fullName,
                                                organizationName: response.organizationName,
                                                followers: "\(response.followers)",
                                                pictureURL: response.pictureURL,
                                                openDealsCount: "\(response.openDealsCount)",
                                                closedDealsCount: "\(response.closedDealsCount)",
                                                isActive: response.isActive ? "Yes": "No",
                                                lastUpdated: readableDate(using: response.lastUpdated),
                                                email: response.email)
        
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.showPersonDetails(using: viewModel)
        }
    }
    
    private func readableDate(using dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        guard let date = dateFormatter.date(from: dateString) else { return dateString }
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        
        return dateFormatter.string(from: date)
    }
}
