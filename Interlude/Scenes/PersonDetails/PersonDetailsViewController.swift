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
    
    private func configureLifecycle() {
        let presenter = PersonDetailsPresenter(viewController: self)
        interactor = PersonDetailsInteractor(presenter: presenter)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let request = request {
            interactor?.requestPersonDetails(using: request)
        }
    }
    
    func showPersonDetails(using viewModel: PersonDetails.ViewModel) {
        self.viewModel = viewModel
        tableView.reloadData()
        print(viewModel)
    }
}

extension PersonDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
