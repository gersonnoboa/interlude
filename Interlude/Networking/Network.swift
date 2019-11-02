//
//  Network.swift
//  Interlude
//
//  Created by Gerson Noboa on 02/11/2019.
//  Copyright © 2019 Heavenlapse. All rights reserved.
//

import Foundation

final class Network {
    static func get(_ urlString: String,
                    session: URLSession = URLSession(configuration: .default),
                    completion: @escaping () -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        let task = session.dataTask(with: url) { data, response, error in
            completion()
        }
        
        task.resume()
    }
}
