//
//  QuestionsViewController.swift
//  Interlude
//
//  Created by Gerson Noboa on 05/11/2019.
//  Copyright (c) 2019 Heavenlapse. All rights reserved.
//

import UIKit

protocol QuestionsViewControllerProtocol: class {
    func showQuestions(with viewModel: Questions.ViewModel)
}

final class QuestionsViewController: UIViewController, QuestionsViewControllerProtocol {
    @IBOutlet weak var tableView: UITableView!
    
    var interactor: QuestionsInteractorProtocol?
    var viewModel: Questions.ViewModel?
    var router: QuestionsRouterProtocol?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureLifecycle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startRequest()
        tableView.register(DynamicCell.viewNib(), forCellReuseIdentifier: DynamicCell.identifier())
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
    
    func configureLifecycle() {
        let worker = QuestionsWorker()
        let presenter = QuestionsPresenter(viewController: self)
        interactor = QuestionsInteractor(presenter: presenter, worker: worker)
        router = QuestionsRouter(viewController: self)
    }
    
    func startRequest() {
        interactor?.requestQuestions()
    }
  
    func showQuestions(with viewModel: Questions.ViewModel) {
        self.viewModel = viewModel
        tableView.reloadData()
    }
}

extension QuestionsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.questions.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: DynamicCell.identifier()) as! DynamicCell
        let question = viewModel.questions[indexPath.row]
        cell.dynamicLabel.text = question
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.navigateToAnswer()
    }
}
