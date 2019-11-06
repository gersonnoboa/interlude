//
//  PersonDetailsViewController.swift
//  Interlude
//
//  Created by Gerson Noboa on 02/11/2019.
//  Copyright © 2019 Heavenlapse. All rights reserved.
//

import UIKit

protocol PersonDetailsViewControllerProtocol: class {
    func showPersonDetails(using viewModel: PersonDetails.ViewModel)
}

final class PersonDetailsViewController: UIViewController, PersonDetailsViewControllerProtocol {
    @IBOutlet weak var tableView: UITableView!
    var request: PersonDetails.Request?
    var interactor: PersonDetailsInteractorProtocol?
    private var viewModel: PersonDetails.ViewModel?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureLifecycle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let request = request {
            interactor?.requestPersonDetails(using: request)
        }
        
        view.backgroundColor = Constants.backgroundColor
        configureTableView()
    }
    
    private func configureLifecycle() {
        let presenter = PersonDetailsPresenter(viewController: self)
        let worker = PersonDetailsWorker()
        interactor = PersonDetailsInteractor(presenter: presenter, worker: worker)
    }
    
    private func configureTableView() {
        tableView.register(PersonDetailsNameImageCell.viewNib(), forCellReuseIdentifier: PersonDetailsNameImageCell.identifier())
        tableView.register(PersonDetailsDataCell.viewNib(), forCellReuseIdentifier: PersonDetailsDataCell.identifier())
        tableView.backgroundColor = Constants.backgroundColor
        tableView.tableFooterView = UIView()
    }
    
    func showPersonDetails(using viewModel: PersonDetails.ViewModel) {
        self.viewModel = viewModel
        tableView.reloadData()
    }
}

extension PersonDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    enum Rows: Int {
        case nameImage
        case organization
        case email
        case followers
        case openDeals
        case closedDeals
        case isActive
        case lastUpdated
        
        static var count: Int { return Rows.lastUpdated.rawValue + 1 }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return UITableViewCell() }
        
        let row = Rows(rawValue: indexPath.row)!
        
        if row == .nameImage {
            let cell = tableView.dequeueReusableCell(withIdentifier: PersonDetailsNameImageCell.identifier()) as! PersonDetailsNameImageCell
            
            cell.nameLabel.text = viewModel.fullName
            cell.photoImageView?.loadImage(urlString: viewModel.pictureURL)
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PersonDetailsDataCell.identifier()) as! PersonDetailsDataCell
        
        switch row {
        case .organization:
            cell.titleLabel.text = "Organization"
            cell.descriptionLabel.text = viewModel.organizationName
        case .email:
            cell.titleLabel.text = "Email"
            cell.descriptionLabel.text = viewModel.email
        case .followers:
            cell.titleLabel.text = "Followers"
            cell.descriptionLabel.text = viewModel.followers
        case .openDeals:
            cell.titleLabel.text = "Open deals"
            cell.descriptionLabel.text = viewModel.openDealsCount
        case .closedDeals:
            cell.titleLabel.text = "Closed deals"
            cell.descriptionLabel.text = viewModel.closedDealsCount
        case .isActive:
            cell.titleLabel.text = "Is active"
            cell.descriptionLabel.text = viewModel.isActive
        case .lastUpdated:
            cell.titleLabel.text = "Last updated"
            cell.descriptionLabel.text = viewModel.lastUpdated
        default: break
        }
        
        return cell
    }
}
