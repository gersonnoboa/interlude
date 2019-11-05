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
    func showRefreshControlUpdate(_ updateText: String, shouldRefresh: Bool)
    func showLoading()
    func hideLoading()
    func showError()
}

class PersonListViewController: UIViewController, PersonListViewControllerProtocol {
    @IBOutlet weak var tableView: UITableView!
    var interactor: PersonListInteractorProtocol?
    var router: PersonListRouterProtocol?
    var viewModel: PersonList.ViewModel?
    var refreshControl = UIRefreshControl()
    var loadingView: LoadingView?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureLifecycle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        view.backgroundColor = Constants.backgroundColor
        
        startRequest(isFromPullToRefresh: false)
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
        
        tableView.backgroundColor = Constants.backgroundColor
        tableView.tableFooterView = UIView()
    }
    
    func startRequest(isFromPullToRefresh: Bool) {
        let request = PersonList.Request(isFromPullToRefresh: isFromPullToRefresh)
        interactor?.requestPersonList(using: request)
    }
    
    @objc func refreshTableView() {
        startRequest(isFromPullToRefresh: true)
    }
    
    func showPersonList(using viewModel: PersonList.ViewModel) {
        self.viewModel = viewModel
        tableView.reloadData()
    }
    
    func showRefreshControlUpdate(_ updateText: String, shouldRefresh: Bool) {
        if !shouldRefresh && refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
        
        refreshControl.attributedTitle = NSAttributedString(string: updateText)
    }
    
    func showLoading() {
        if loadingView == nil {
            loadingView = LoadingView.viewNib().instantiate(withOwner: nil, options: nil).first as? LoadingView
        }
        
        loadingView!.frame = view.frame
        loadingView!.alpha = 0
        view.addSubview(loadingView!)
        
        UIView.animate(withDuration: Constants.animationDuration) { [weak self] in
            self?.loadingView?.alpha = 1
        }
    }
    
    func hideLoading() {
        UIView.animate(withDuration: Constants.animationDuration, animations: { [weak self] in
            self?.loadingView?.alpha = 0
        }, completion: { [weak self] _ in
            self?.loadingView?.removeFromSuperview()
        })
    }
    
    func showError() {
        let alert = UIAlertController(title: "Error", message: "There was an error with the request. Please try again later.", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okButton)
        
        present(alert, animated: true, completion: nil)
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
