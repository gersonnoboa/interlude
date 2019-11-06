//
//  AnswerInteractor.swift
//  Interlude
//
//  Created by Gerson Noboa on 06/11/2019.
//  Copyright (c) 2019 Heavenlapse. All rights reserved.
//

import Foundation

protocol AnswerInteractorProtocol {
    func fetchAnswer(with request: Answer.Request)
}

final class AnswerInteractor: AnswerInteractorProtocol {
    var presenter: AnswerPresenterProtocol?
    var worker: AnswerWorkerProtocol?
  
    init(presenter: AnswerPresenterProtocol,
         worker: AnswerWorkerProtocol) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func fetchAnswer(with request: Answer.Request) {
        //self?.presenter?.presentAnswer(with: response)
    }
}
