//
//  PersonDetailsModels.swift
//  Interlude
//
//  Created by Gerson Noboa on 02/11/2019.
//  Copyright © 2019 Heavenlapse. All rights reserved.
//

import Foundation

struct PersonDetails {
    struct Request {
        var firstName: String
        var lastName: String
        var organizationName: String
        var followers: Int
    }
    
    struct Response {
        var firstName: String
        var lastName: String
        var organizationName: String
        var followers: Int
    }
    
    struct ViewModel {
        var firstName: String
        var lastName: String
        var organizationName: String
        var followers: String
    }
}
