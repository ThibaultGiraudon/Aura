//
//  EndPointsFake.swift
//  AuraTests
//
//  Created by Thibault Giraudon on 06/03/2025.
//

import Foundation
@testable import Aura

extension API {
    enum EndPointsFake: API.EndPoint {
        case fake
        
        var path: String { "/fake/" }
        
        var authorization: Aura.API.Authorization { .none }
        
        var method: Aura.API.Method { .get }
        
        var body: Data? { nil }
        
        var request: URLRequest? { nil }
        
        
    }
}
