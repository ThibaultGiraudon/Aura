//
//  AuthenticationViewModelTests.swift
//  AuraTests
//
//  Created by Thibault Giraudon on 06/03/2025.
//

import XCTest
@testable import Aura

final class AuthenticationViewModelTests: XCTestCase {
    let viewModel = AuthenticationViewModel {}
    
    func testIsValidEmail() async {
        viewModel.username = "test"
        
        let expectation = XCTestExpectation(description: "Wait")
        
        Task {
            await viewModel.login()
            try! await Task.sleep(nanoseconds: 100_000_000)
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 2.0)
        
        XCTAssertTrue(viewModel.showError)
        XCTAssertEqual(viewModel.alertMessage, "Please enter a valid email.")
    }
    
    func testloginSucceed() async {
        let fakeAPI = APIFake()
        fakeAPI.data = try! JSONSerialization.data(withJSONObject: ["token": "token"])
        let viewModel = AuthenticationViewModel({}, api: fakeAPI)
        viewModel.username = "test@aura.app"
        
        let expectation = XCTestExpectation(description: "Wait")
        
        Task {
            await viewModel.login()
            try! await Task.sleep(nanoseconds: 500_000_000)
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 2.0)
        
        XCTAssertEqual(API.shared.token, "token")
    }
    
    func testDataDontContainToken() async {
        let fakeAPI = APIFake()
        fakeAPI.data = try! JSONSerialization.data(withJSONObject: ["notToken": "token"])
        let viewModel = AuthenticationViewModel({}, api: fakeAPI)
        viewModel.username = "test@aura.app"
        
        let expectation = XCTestExpectation(description: "Wait")
        
        Task {
            await viewModel.login()
            try! await Task.sleep(nanoseconds: 500_000_000)
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 2.0)
        
        XCTAssertEqual(viewModel.alertMessage, "An error occured while processing the reponse.")
    }
    
    func testLoginFailedWithBadRequest() async {
        let fakeAPI = APIFake()
        fakeAPI.shouldSucceed = false
        fakeAPI.error = API.Error.badRequest
        
        let viewModel = AuthenticationViewModel({}, api: fakeAPI)
        viewModel.username = "test@aura.app"
        
        let expectation = XCTestExpectation(description: "Wait")
        
        Task {
            await viewModel.login()
            try! await Task.sleep(nanoseconds: 500_000_000)
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 2.0)
        
        XCTAssertTrue(viewModel.showError)
        XCTAssertEqual(viewModel.alertMessage, "Fail to login (bad username and/or password).")
    }
    
    
    func testLoginFailedWithInternalError() async {
        let fakeAPI = APIFake()
        fakeAPI.shouldSucceed = false
        fakeAPI.error = API.Error.unauthorized
        
        let viewModel = AuthenticationViewModel({}, api: fakeAPI)
        viewModel.username = "test@aura.app"
        
        let expectation = XCTestExpectation(description: "Wait")
        
        Task {
            await viewModel.login()
            try! await Task.sleep(nanoseconds: 500_000_000)
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 2.0)
        
        XCTAssertTrue(viewModel.showAlert)
        XCTAssertEqual(viewModel.alertMessage, "Unauthorized request.")
    }
    
}
