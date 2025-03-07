//
//  API.swift
//  Aura
//
//  Created by Thibault Giraudon on 05/03/2025.
//

import Foundation

protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol { }

protocol APIProtocol {
    func call<T: Decodable>(endPoint: API.EndPoint) async throws -> T
    func call(endPoint: API.EndPoint) async throws 
}

class API: APIProtocol {
    @Published var token = ""
    static var shared = API()
    private var session: URLSessionProtocol = URLSession(configuration: .default)
    
    
    private init() {}
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    func call<T: Decodable>(endPoint: EndPoint) async throws -> T {
        guard var request = endPoint.request else {
            throw API.Error.malformed
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await session.data(for: request)
        

        guard let httpResponse = response as? HTTPURLResponse else {
            throw API.Error.responseError
        }
        
        guard httpResponse.statusCode == 200 else {
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
        
        if data.isEmpty, T.self == Void.self {
            return () as! T
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func call(endPoint: EndPoint) async throws {
        guard var request = endPoint.request else {
            throw API.Error.malformed
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await session.data(for: request)
        

        guard let httpResponse = response as? HTTPURLResponse else {
            throw API.Error.responseError
        }
        
        guard httpResponse.statusCode == 200 else {
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
    }
}
