//
//  AnswerViewController.swift
//  Interlude
//
//  Created by Gerson Noboa on 06/11/2019.
//  Copyright (c) 2019 Heavenlapse. All rights reserved.
//

import UIKit

protocol AnswerViewControllerProtocol: class {
    func showAnswer(with viewModel: Answer.ViewModel)
}

final class AnswerViewController: UIViewController, AnswerViewControllerProtocol {
    @IBOutlet weak var tableView: UITableView!
    
    var interactor: AnswerInteractorProtocol?
    var viewModel: Answer.ViewModel?
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configureLifecycle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startRequest()
    }
    
    func configureLifecycle() {
        let worker = AnswerWorker()
        let presenter = AnswerPresenter(viewController: self)
        interactor = AnswerInteractor(presenter: presenter, worker: worker)
    }
    
    func startRequest() {
        let request = Answer.Request()
        interactor?.fetchAnswer(with: request)
    }
  
    func showAnswer(with viewModel: Answer.ViewModel) {
        self.viewModel = viewModel
        tableView.reloadData()
    }
}

extension AnswerViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //guard let viewModel = viewModel else { return UITableViewCell() }
        return UITableViewCell()
    }
}
