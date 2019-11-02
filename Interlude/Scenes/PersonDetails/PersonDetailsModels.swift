//
//  PersonDetailsModels.swift
//  Interlude
//
//  Created by Gerson Noboa on 02/11/2019.
//  Copyright © 2019 Heavenlapse. All rights reserved.
//

import Foundation

struct PersonDetails {
    struct Response {
        var id: Int
        var firstName: String
        var lastName: String
        var organizationName: String
    }
    
    struct Remote: Codable {
        var id: Int
        var firstName: String
        var lastName: String
        var orgName: String
    }
}
