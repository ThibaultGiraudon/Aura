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
            throw API.Error.malformed
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw API.Error.responseError
        }
        
        guard httpResponse.statusCode == 200 else {
            print(httpResponse.statusCode)
            switch httpResponse.statusCode {
                case 400:
                    throw API.Error.badRequest
                case 401:
                    throw API.Error.unauthorized
                case 404:
                    throw API.Error.notFound
                default:
                    throw API.Error.internalServerError
            }
        }
        
        return data
    }
}
