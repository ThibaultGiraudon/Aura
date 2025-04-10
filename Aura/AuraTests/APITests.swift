//
//  APITests.swift
//  APITests
//
//  Created by Thibault Giraudon on 06/03/2025.
//

import XCTest
@testable import Aura

final class APITests: XCTestCase {

    func testCallWithUnauthorizedError() async {
        let fakeSession = URLSessionFake()
        fakeSession.fakeResponse = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 401, httpVersion: nil, headerFields: nil)
        
        let api = API(session: fakeSession)
        
        do {
            var _: [String: String] = try await api.call(endPoint: API.AuthEndPoints.test)
            XCTFail("Request should throw error")
        } catch API.Error.unauthorized {
            
        } catch {
            XCTFail("Erreur inattendu: \(error)")
        }
    }
    
    func testCallWithNotFoundError() async {
        let fakeSession = URLSessionFake()
        fakeSession.fakeResponse = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 404, httpVersion: nil, headerFields: nil)
        
        let api = API(session: fakeSession)
        
        do {
            var _: [String: String] = try await api.call(endPoint: API.AuthEndPoints.test)
            XCTFail("Request should throw error")
        } catch API.Error.notFound {
            
        } catch {
            XCTFail("Erreur inattendu: \(error)")
        }
    }
    
    func testCallWithBadRequestError() async {
        let fakeSession = URLSessionFake()
        fakeSession.fakeResponse = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 400, httpVersion: nil, headerFields: nil)
        
        let api = API(session: fakeSession)
        
        do {
            var _: [String: String] = try await api.call(endPoint: API.AuthEndPoints.test)
            XCTFail("Request should throw error")
        } catch API.Error.badRequest {
            
        } catch {
            XCTFail("Erreur inattendu: \(error)")
        }
    }
    
    func testCallWithIternalError() async {
        let fakeSession = URLSessionFake()
        fakeSession.fakeResponse = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)
        
        let api = API(session: fakeSession)
        
        do {
            var _: [String: String] = try await api.call(endPoint: API.AuthEndPoints.test)
            XCTFail("Request should throw error")
        } catch API.Error.internalServerError {
            
        } catch {
            XCTFail("Erreur inattendu: \(error)")
        }
    }
    
    func testCallWithMalformedError() async {
        let fakeSession = URLSessionFake()
        fakeSession.fakeResponse = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 400, httpVersion: nil, headerFields: nil)
        
        let api = API(session: fakeSession)
        
        do {
            var _: [String: String] = try await api.call(endPoint: API.EndPointsFake.fake)
            XCTFail("Request should throw error")
        } catch API.Error.malformed {
            
        } catch {
            XCTFail("Erreur inattendu: \(error)")
        }
    }
    
    func testCallWithoutResponseWithUnauthorizedError() async {
        let fakeSession = URLSessionFake()
        fakeSession.fakeResponse = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 401, httpVersion: nil, headerFields: nil)
        
        let api = API(session: fakeSession)
        
        do {
            try await api.call(endPoint: API.AuthEndPoints.test)
            XCTFail("Request should throw error")
        } catch API.Error.unauthorized {
            
        } catch {
            XCTFail("Erreur inattendu: \(error)")
        }
    }
    
    func testCallWithoutResponseWithNotFoundError() async {
        let fakeSession = URLSessionFake()
        fakeSession.fakeResponse = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 404, httpVersion: nil, headerFields: nil)
        
        let api = API(session: fakeSession)
        
        do {
            try await api.call(endPoint: API.AuthEndPoints.test)
            XCTFail("Request should throw error")
        } catch API.Error.notFound {
            
        } catch {
            XCTFail("Erreur inattendu: \(error)")
        }
    }
    
    func testCallWithoutResponseWithBadRequestError() async {
        let fakeSession = URLSessionFake()
        fakeSession.fakeResponse = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 400, httpVersion: nil, headerFields: nil)
        
        let api = API(session: fakeSession)
        
        do {
            try await api.call(endPoint: API.AuthEndPoints.test)
            XCTFail("Request should throw error")
        } catch API.Error.badRequest {
            
        } catch {
            XCTFail("Erreur inattendu: \(error)")
        }
    }
    
    func testCallWithoutResponseWithIternalError() async {
        let fakeSession = URLSessionFake()
        fakeSession.fakeResponse = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)
        
        let api = API(session: fakeSession)
        
        do {
            try await api.call(endPoint: API.AuthEndPoints.test)
            XCTFail("Request should throw error")
        } catch API.Error.internalServerError {
            
        } catch {
            XCTFail("Erreur inattendu: \(error)")
        }
    }
    
    func testCallWithoutResponseWithMalformedError() async {
        let fakeSession = URLSessionFake()
        fakeSession.fakeResponse = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 400, httpVersion: nil, headerFields: nil)
        
        let api = API(session: fakeSession)
        
        do {
            try await api.call(endPoint: API.EndPointsFake.fake)
            XCTFail("Request should throw error")
        } catch API.Error.malformed {
            
        } catch {
            XCTFail("Erreur inattendu: \(error)")
        }
    }
    
    func testAuthEndPointShouldSucceed() async {
        let fakeSession = URLSessionFake()
        fakeSession.fakeData = try! JSONSerialization.data(withJSONObject: ["token": "testTokenName"])
        
        let api = API(session: fakeSession)
        
        do {
            let jsonData: [String: String] = try await api.call(endPoint: API.AuthEndPoints.authenticate(username: "test@aura.app", password: "test123"))
            
            XCTAssertEqual(jsonData, ["token": "testTokenName"])
            
        } catch {
            
        }
    }
    
    func testAccountEndPointShouldSucceed() async {
        let fakeSession = URLSessionFake()
        
        var accountCorrectData: Data? {
            let bundle = Bundle(for: APITests.self)
            guard let url = bundle.url(forResource: "Account", withExtension: "json") else {
                return nil
            }
            return try! Data(contentsOf: url)
        }
        
        
        fakeSession.fakeData = accountCorrectData
        
        let api = API(session: fakeSession)
        
        do {
            let json: Account = try await api.call(endPoint: API.AccountEndPoints.account)
            
            guard let accountCorrectJSON = try? JSONDecoder().decode(Account.self, from: accountCorrectData!) else {
                return
            }
            
            XCTAssertEqual(json.currentBalance, accountCorrectJSON.currentBalance)
            
        } catch {
            
        }
    }
    
    func testTransferEndPointShouldSucceed() async {
        let fakeSession = URLSessionFake()
        let api = API(session: fakeSession)
        
        do {
            try await api.call(endPoint: API.AccountEndPoints.transfer(recipient: "test@aura.app", amount: 123.3))
        } catch {
            XCTFail("Should not throw error")
        }
    }
    
    func testIsValidEmail() {
        let correctEmail = "test@aura.app"
        let incorrectEmail = "test"
        XCTAssertFalse(incorrectEmail.isValidEmail)
        XCTAssertTrue(correctEmail.isValidEmail)
    }
    
    func testIsValidPhone() {
        let correctPhone = "0612345678"
        let incorrectPhone = "0645as678"
        let anotherCorrectPhone = "+33 06 12 34 56 78"
        XCTAssertTrue(correctPhone.isValidPhone)
        XCTAssertFalse(incorrectPhone.isValidPhone)
        XCTAssertTrue(anotherCorrectPhone.isValidPhone)
    }
    
}

