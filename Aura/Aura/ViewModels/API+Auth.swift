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
        
        var authorization: Authorization { .none}

        var method: Method {
            switch self {
                case .authenticate:
                    return .post
            }
        }
        
        var path: String {
            switch self {
                case .authenticate:
                    "/auth/"
            }
        }
        
        var queryItems: [String : String]? {
            switch self {
                case .authenticate (let username, let password):
                    return ["username": username, "password": password]
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
            if queryItems != nil {
                let data = try? JSONSerialization.data(withJSONObject: queryItems!)
                urlRequest.httpBody = data
            }
            urlRequest.httpMethod = self.method.rawValue
        
            return urlRequest
        }
    }
}
