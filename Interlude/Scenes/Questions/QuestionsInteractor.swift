//
//  QuestionsInteractor.swift
//  Interlude
//
//  Created by Gerson Noboa on 05/11/2019.
//  Copyright (c) 2019 Heavenlapse. All rights reserved.
//

import Foundation

protocol QuestionsInteractorProtocol {
    func requestQuestions()
}

final class QuestionsInteractor: QuestionsInteractorProtocol {
    var presenter: QuestionsPresenterProtocol
    var worker: QuestionsWorkerProtocol
    
    init(presenter: QuestionsPresenterProtocol, worker: QuestionsWorkerProtocol) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func requestQuestions() {
        let response = worker.fetchQuestions()
        
        presenter.presentQuestions(with: response)
    }
}
