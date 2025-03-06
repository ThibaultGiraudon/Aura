//
//  API+Account.swift
//  Aura
//
//  Created by Thibault Giraudon on 05/03/2025.
//

import Foundation

extension API {
    enum AccountEndPoints: EndPoint {
        case account
        case transfer(recipient: String, amount: Double)
        
        var authorization: Authorization {
            switch self {
                case .account:
                    return .user
                case .transfer:
                    return .user
            }
        }

        var method: Method {
            switch self {
                case .account:
                    return .get
                case .transfer:
                    return .post
            }
        }
        
        var path: String {
            switch self {
                case .account:
                    "/account/"
                case .transfer:
                    "/account/transfer/"
            }
        }
        
        var body: Data? {
            switch self {
                case .account:
                    return nil
                case .transfer(let recipient, let amount):
                    let data: [String: Any] = ["recipient": recipient, "amount" : amount]
                    return try? JSONSerialization.data(withJSONObject: data)
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
            if authorization == .user {
                urlRequest.setValue(API.shared.token, forHTTPHeaderField: "token")
            }
        
            return urlRequest
        }
    }
}
