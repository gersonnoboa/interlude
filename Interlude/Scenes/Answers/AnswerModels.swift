//
//  AnswerModels.swift
//  Interlude
//
//  Created by Gerson Noboa on 06/11/2019.
//  Copyright (c) 2019 Heavenlapse. All rights reserved.
//

import Foundation

struct Answer {
    struct Request {
        var index: Int
    }
    
    struct Response {
        var text: String
    }
    
    struct ViewModel {
        var text: String
    }
}
