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
    @IBOutlet weak var textView: UITextView!
    
    var interactor: AnswerInteractorProtocol?
    var viewModel: Answer.ViewModel?
    var request: Answer.Request?
    
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
        guard let request = request else { return }
        
        interactor?.requestAnswer(with: request)
    }
  
    func showAnswer(with viewModel: Answer.ViewModel) {
        self.viewModel = viewModel
        textView.text = viewModel.text
    }
}
