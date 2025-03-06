//
//  API.swift
//  Aura
//
//  Created by Thibault Giraudon on 05/03/2025.
//

import Foundation

class API {
    @Published var token = ""
    static var shared = API()
    
    private init() {}
    
    func call(endPoint: EndPoint) async throws -> Data {
        let session = URLSession(configuration: .default)
        
        guard var request = endPoint.request else {
            print("Bad url")
            throw URLError(.badURL)
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print("Status error")
            throw URLError(.badServerResponse)
        }
        
        return data
    }
}
