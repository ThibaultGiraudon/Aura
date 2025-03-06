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
    func call(endPoint: any Aura.API.EndPoint) async throws -> Data {
        if shouldSucceed {
            return data
        } else {
            throw error
        }
    }
    
    
}
