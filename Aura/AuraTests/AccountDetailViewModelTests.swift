//
//  AccountDetailViewModelTests.swift
//  AuraTests
//
//  Created by Thibault Giraudon on 06/03/2025.
//

import XCTest
@testable import Aura

final class AccountDetailViewModelTests: XCTestCase {
    func testGetAccountSucceed() async {
        var correctData: Data? {
            let bundle = Bundle(for: AccountDetailViewModelTests.self)
            let url = bundle.url(forResource: "Account", withExtension: "json")!
            return try! Data(contentsOf: url)
        }
        let fakeAPI = APIFake()
        fakeAPI.data = correctData!
        let viewModel = AccountDetailViewModel(api: fakeAPI)
        
        let expectation = XCTestExpectation(description: "wait")
        
        Task {
            await viewModel.getAccount()
            try! await Task.sleep(nanoseconds: 100_000_000)
            expectation.fulfill()
            XCTAssertEqual(viewModel.totalAmount, "€5459.32")
            XCTAssertEqual(viewModel.allTransactions.first!.description, "IKEA")
        }
        
        await fulfillment(of: [expectation], timeout: 2.0)
    }
    
    func testGetAccountFailedWithUnauthorized() async {
        let fakeAPI = APIFake()
        fakeAPI.shouldSucceed = false
        fakeAPI.error = API.Error.unauthorized
        let viewModel = AccountDetailViewModel(api: fakeAPI)
        
        let expectation = XCTestExpectation(description: "wait")
        
        Task {
            await viewModel.getAccount()
            try! await Task.sleep(nanoseconds: 100_000_000)
            expectation.fulfill()
            XCTAssertTrue(viewModel.showAlert)
            XCTAssertEqual(viewModel.alertMessage, "Unauthorized request.")
        }
        
        await fulfillment(of: [expectation], timeout: 2.0)
    }
}
