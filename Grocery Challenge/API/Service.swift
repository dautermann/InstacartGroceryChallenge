//
//  Service.swift
//  Grocery Challenge
//
//  Created by Andrew Crookston on 5/29/18.
//  Copyright © 2018 Instacart. All rights reserved.
//

import Foundation

// MARK: - Networking - if you want to create your own service layer

protocol Requests {
    var url: URL { get }
}

protocol Service {
    func get(request: Requests, completion: @escaping (Result<Data>) -> Void)
}

final class NetworkService: Service {
    func get(request: Requests, completion: @escaping (Result<Data>) -> Void) {
        URLSession.shared.dataTask(with: request.url) { (data, response, error) in
            if let error = error {
                completion(.error(error))
                return
            }
            guard let data = data else {
                completion(.error(ServiceError.invalidData))
                return
            }
            completion(.success(data))
        }.resume()
    }
}

enum ServiceError: Error {
    case invalidData
}
