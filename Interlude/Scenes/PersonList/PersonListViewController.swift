//
//  ViewController.swift
//  Interlude
//
//  Created by Gerson Noboa on 02/11/2019.
//  Copyright © 2019 Heavenlapse. All rights reserved.
//

import UIKit

protocol PersonListViewControllerProtocol: class {
    func showPersonList(using viewModel: PersonList.ViewModel)
}

class PersonListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var interactor: PersonListInteractorProtocol?
    var router: PersonListRouterProtocol?
    var viewModel: PersonList.ViewModel?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureLifecycle()
    }
    
    private func configureLifecycle() {
        let presenter = PersonListPresenter(viewController: self)
        let worker = PersonListWorker()
        interactor = PersonListInteractor(presenter: presenter, worker: worker)
        router = PersonListRouter(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = PersonList.Request()
        interactor?.requestPersonList(using: request)
        
        tableView.register(PersonListCell.viewNib(), forCellReuseIdentifier: PersonListCell.identifier())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router?.passDataToNextScene(using: segue)
    }
}

extension PersonListViewController: PersonListViewControllerProtocol {
    func showPersonList(using viewModel: PersonList.ViewModel) {
        self.viewModel = viewModel
        tableView.reloadData()
    }
}

extension PersonListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.personList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return UITableViewCell() }
        
        let person = viewModel.personList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: PersonListCell.identifier()) as! PersonListCell
        cell.nameLabel.text = person.fullName
        cell.organizationLabel.text = person.organizationName
        cell.followersLabel.text = person.followers
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.navigateToPersonDetails()
    }
}
