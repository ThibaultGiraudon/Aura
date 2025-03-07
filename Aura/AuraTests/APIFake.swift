//
//  APIFake.swift
//  AuraTests
//
//  Created by Thibault Giraudon on 06/03/2025.
//

import Foundation
@testable import Aura

class APIFake: APIProtocol {
    var shouldSucceed = true
    var data = Data()
    var error: Error = URLError(.badServerResponse)
    func call<T: Decodable>(endPoint: any Aura.API.EndPoint) async throws -> T {
        if shouldSucceed {
            return try JSONDecoder().decode(T.self, from: data)
        } else {
            throw error
        }
    }
    
    func call(endPoint: any API.EndPoint) async throws {
        if !shouldSucceed {
            throw error
        }
    }
    
    
}
