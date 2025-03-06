//
//  APi+Error.swift
//  Aura
//
//  Created by Thibault Giraudon on 05/03/2025.
//

import Foundation

extension API {
    enum Error: Swift.Error, LocalizedError {
        case malformed
        case badRequest
        case unauthorized
        case notFound
        case responseError
        case internalServerError
        
        var errorDescription: String? {
            switch self {
                case .malformed:
                    "The request is malformed."
                case .badRequest:
                    "Fail to login (bad username and/or password)."
                case .unauthorized:
                    "Unauthorized request."
                case .notFound:
                    "Page or resource not found."
                case .responseError:
                    "An error occured while processing the reponse."
                case .internalServerError:
                    "We are encountering a problem with our server. Please try aigain later."
            }
        }
        
    }
}
