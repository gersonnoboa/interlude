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

final class PersonDetailsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var personID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(personID)
    }
}

extension PersonDetailsViewController: PersonDetailsViewControllerProtocol {
    func showPersonDetails(using viewModel: PersonDetails.ViewModel) {
        
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
