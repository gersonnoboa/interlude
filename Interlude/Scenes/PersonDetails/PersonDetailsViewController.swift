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
        interactor = PersonDetailsInteractor(presenter: presenter)
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
        print(viewModel)
    }
}

extension PersonDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    enum Rows: Int {
        case nameImage
        case organization
        case followers
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
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
        case .followers:
            cell.titleLabel.text = "Followers"
            cell.descriptionLabel.text = viewModel.followers
        default: break
        }
        
        return cell
    }
}
