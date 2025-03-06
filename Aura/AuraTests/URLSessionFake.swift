//
//  URLSessionFake.swift
//  AuraTests
//
//  Created by Thibault Giraudon on 06/03/2025.
//

import Foundation
@testable import Aura

class URLSessionFake: URLSessionProtocol {
    var fakeData: Data?
    var fakeResponse: URLResponse?
    var fakeError: Error?
    
    init(fakeData: Data? = nil, fakeResponse: URLResponse? = nil, fakeError: Error? = nil) {
        self.fakeData = fakeData
        self.fakeResponse = fakeResponse
        self.fakeError = fakeError
    }
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = fakeError {
            throw error
        }
        
        let data = fakeData ?? Data()
        let response = fakeResponse ?? HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        
        return (data, response)
    }
}
