//
//  Network.swift
//  Interlude
//
//  Created by Gerson Noboa on 02/11/2019.
//  Copyright © 2019 Heavenlapse. All rights reserved.
//

import Foundation

final class Network {
    static let shared = Network()
    let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func getJSON<T: RemoteObjectProtocol>(_ urlString: String, completion: @escaping (T?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, let remoteObject: T = self?.decodeJSON(using: data) else {
                completion(nil)
                return
            }
            
            completion(remoteObject)
        }
        
        task.resume()
    }
    
    private func decodeJSON<T: RemoteObjectProtocol>(using data: Data) -> T? {
        let decoder = JSONDecoder()
        
        return try! decoder.decode(T.self, from: data)
    }
}
