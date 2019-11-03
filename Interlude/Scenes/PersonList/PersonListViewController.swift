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
    func showRefreshControlUpdate(_ update: String)
}

class PersonListViewController: UIViewController, PersonListViewControllerProtocol {
    @IBOutlet weak var tableView: UITableView!
    var interactor: PersonListInteractorProtocol?
    var router: PersonListRouterProtocol?
    var viewModel: PersonList.ViewModel?
    var refreshControl = UIRefreshControl()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureLifecycle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: true)
        }
        
        let request = PersonList.Request(needsNetworkLoad: false)
        interactor?.requestPersonList(using: request)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router?.passDataToNextScene(using: segue)
    }
    
    private func configureLifecycle() {
        let presenter = PersonListPresenter(viewController: self)
        let worker = PersonListWorker()
        interactor = PersonListInteractor(presenter: presenter, worker: worker)
        router = PersonListRouter(viewController: self)
    }
    
    private func configureTableView() {
        tableView.register(PersonListCell.viewNib(), forCellReuseIdentifier: PersonListCell.identifier())
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refreshTableView() {
        let request = PersonList.Request(needsNetworkLoad: true)
        interactor?.requestPersonList(using: request)
    }
    
    func showPersonList(using viewModel: PersonList.ViewModel) {
        self.viewModel = viewModel
        tableView.reloadData()
        
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }
    
    func showRefreshControlUpdate(_ update: String) {
        refreshControl.attributedTitle = NSAttributedString(string: update)
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
