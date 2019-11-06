//
//  AnswerWorker.swift
//  Interlude
//
//  Created by Gerson Noboa on 06/11/2019.
//  Copyright (c) 2019 Heavenlapse. All rights reserved.
//

import UIKit

protocol AnswerWorkerProtocol {
    func fetchAnswer(with request: Answer.Request) -> Answer.Response
}

final class AnswerWorker: AnswerWorkerProtocol {
    func fetchAnswer(with request: Answer.Request) -> Answer.Response {
        return Answer.Response()
    }
}
