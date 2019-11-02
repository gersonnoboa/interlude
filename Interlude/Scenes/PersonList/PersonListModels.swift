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
        var personList: [PersonDetails.Response]
    }
    
    struct ViewModel {
        var personList: [PersonDetails.ViewModel]
    }
    
    struct Remote: Codable, RemoteObjectProtocol {
        var success: Bool
        var data: [PersonDetails.Remote]
        
        enum CodingKeys: String, CodingKey {
          case success
          case data
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            success = try container.decode(Bool.self, forKey: .success)
            data = try container.decode([PersonDetails.Remote].self, forKey: .data)
        }
    }
}
