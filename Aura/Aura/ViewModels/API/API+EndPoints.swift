//
//  API+EndPoints.swift
//  Aura
//
//  Created by Thibault Giraudon on 05/03/2025.
//

import Foundation

extension API {
    protocol EndPoint {
        var path: String { get }
        var authorization: Authorization { get }
        var method: Method { get }
        var body: Data? { get }
        var request: URLRequest? { get }
    }
    
    enum Authorization: String {
        case none
        case user
    }
    
    enum Method: String {
        case post = "POST"
        case get = "GET"
    }
}
