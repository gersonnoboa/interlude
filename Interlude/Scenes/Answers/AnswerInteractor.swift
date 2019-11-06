//
//  AnswerInteractor.swift
//  Interlude
//
//  Created by Gerson Noboa on 06/11/2019.
//  Copyright (c) 2019 Heavenlapse. All rights reserved.
//

import Foundation

protocol AnswerInteractorProtocol {
    func requestAnswer(with request: Answer.Request)
}

final class AnswerInteractor: AnswerInteractorProtocol {
    var presenter: AnswerPresenterProtocol?
    var worker: AnswerWorkerProtocol?
  
    init(presenter: AnswerPresenterProtocol,
         worker: AnswerWorkerProtocol) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func requestAnswer(with request: Answer.Request) {
        guard let response = worker?.fetchAnswer(with: request) else { return }
        
        presenter?.presentAnswer(with: response)
    }
}
