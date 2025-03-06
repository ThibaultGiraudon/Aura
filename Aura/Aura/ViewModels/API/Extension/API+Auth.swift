//
//  API+Auth.swift
//  Aura
//
//  Created by Thibault Giraudon on 05/03/2025.
//

import Foundation

extension API {
    enum AuthEndPoints: EndPoint {
        case authenticate(username: String, password: String)
        case test
        
        var authorization: Authorization { .none }

        var method: Method {
            switch self {
                case .authenticate:
                    return .post
                case .test:
                    return .get
            }
        }
        
        var path: String {
            switch self {
                case .authenticate:
                    "/auth/"
                case .test:
                    "/"
            }
        }
        
        var body: Data? {
            switch self {
                case .authenticate (let username, let password):
                    let data = ["username": username, "password": password]
                    return try? JSONSerialization.data(withJSONObject: data)
                case .test:
                    return nil
            }
        }

        
        var request: URLRequest? {
            var components = URLComponents()
            components.scheme = API.Constants.scheme
            components.host = API.Constants.host
            components.port = API.Constants.port
            components.path = self.path
            
            
            guard let url = components.url else {
                return nil
            }
            var urlRequest = URLRequest(url: url)
            if body != nil {
                urlRequest.httpBody = body
            }
            urlRequest.httpMethod = self.method.rawValue
        
            return urlRequest
        }
    }
}
