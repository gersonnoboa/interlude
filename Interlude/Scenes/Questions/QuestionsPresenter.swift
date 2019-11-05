//
//  QuestionsPresenter.swift
//  Interlude
//
//  Created by Gerson Noboa on 05/11/2019.
//  Copyright (c) 2019 Heavenlapse. All rights reserved.
//

import Foundation

protocol QuestionsPresenterProtocol {
    func presentQuestions(with response: Questions.Response)
}

final class QuestionsPresenter: QuestionsPresenterProtocol {
    weak var viewController: QuestionsViewControllerProtocol?
    
    init(viewController: QuestionsViewControllerProtocol) {
        self.viewController = viewController
    }
    
    func presentQuestions(with response: Questions.Response) {
        let viewModel = Questions.ViewModel(questions: response.questions)
        viewController?.showQuestions(with: viewModel)
    }
}
