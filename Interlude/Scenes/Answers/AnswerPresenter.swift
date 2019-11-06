//
//  AnswerPresenter.swift
//  Interlude
//
//  Created by Gerson Noboa on 06/11/2019.
//  Copyright (c) 2019 Heavenlapse. All rights reserved.
//

import Foundation

protocol AnswerPresenterProtocol {
    func presentAnswer(with response: Answer.Response)
}

final class AnswerPresenter: AnswerPresenterProtocol {
    weak var viewController: AnswerViewControllerProtocol?
    
    init(viewController: AnswerViewControllerProtocol) {
        self.viewController = viewController
    }
    
    func presentAnswer(with response: Answer.Response) {
        let viewModel = Answer.ViewModel(text: response.text)
        viewController?.showAnswer(with: viewModel)
    }
}
