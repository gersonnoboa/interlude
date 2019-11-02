//
//  Links.swift
//  Interlude
//
//  Created by Gerson Noboa on 02/11/2019.
//  Copyright © 2019 Heavenlapse. All rights reserved.
//

import Foundation

final class Links {
    static var personList: String {
        let apiToken = Constants.apiToken
        
        return "https://heavenlapse.pipedrive.com/v1/persons?api_token=\(apiToken)"
    }
}
