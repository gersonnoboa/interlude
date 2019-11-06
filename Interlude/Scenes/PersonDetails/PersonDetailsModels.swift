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
        var id: Int
    }
    
    struct Response {
        var firstName: String
        var lastName: String
        var organizationName: String
        var followers: Int
        var pictureURL: String?
        var openDealsCount: Int
        var closedDealsCount: Int
        var isActive: Bool
        var lastUpdated: String
        var email: String
    }
    
    struct ViewModel {
        var fullName: String
        var organizationName: String
        var followers: String
        var pictureURL: String?
        var openDealsCount: String
        var closedDealsCount: String
        var isActive: String
        var lastUpdated: String
        var email: String
    }
}
