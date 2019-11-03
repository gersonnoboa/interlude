//
//  PeopleModels.swift
//  Interlude
//
//  Created by Gerson Noboa on 02/11/2019.
//  Copyright © 2019 Heavenlapse. All rights reserved.
//

import Foundation

struct PersonList {
    struct Request {
        
    }
    
    struct Response {
        var personList: [Person.Response]
    }
    
    struct ViewModel {
        var personList: [Person.ViewModel]
    }
    
    struct Remote: Codable, RemoteObjectProtocol {
        var success: Bool
        var data: [Person.Remote]
        
        enum CodingKeys: String, CodingKey {
          case success
          case data
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            success = try container.decode(Bool.self, forKey: .success)
            data = try container.decode([Person.Remote].self, forKey: .data)
        }
    }
}

struct Person {
    struct Response {
        var id: Int
        var firstName: String
        var lastName: String
        var organizationName: String
        var followers: Int
    }
    
    struct ViewModel {
        var fullName: String
        var organizationName: String
        var followers: String
    }
    
    struct Remote: Codable {
        var id: Int
        var firstName: String
        var lastName: String
        var orgName: String
        var followersCount: Int
    }
}

