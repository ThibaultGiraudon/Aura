//
//  MoneyTransferViewModelTest.swift
//  AuraTests
//
//  Created by Thibault Giraudon on 06/03/2025.
//

import XCTest
@testable import Aura

@MainActor
final class MoneyTransferViewModelTest: XCTestCase {
    var viewModel = MoneyTransferViewModel()
    
    func testInvalidEmailAndPhone() {
        viewModel.recipient = "invalid_user"
        viewModel.amount = "100"
        
        viewModel.sendMoney()
        
        XCTAssertEqual(viewModel.transferMessage, "Please enter a valid email or phone.")
    }

    func testInvalidAmount() {
        viewModel.recipient = "test@email.com"
        viewModel.amount = "invalid_amount"
        
        viewModel.sendMoney()
        
        XCTAssertEqual(viewModel.transferMessage, "Please enter a valid amount.")
    }

    func testEmptyFields() {
        viewModel.recipient = ""
        viewModel.amount = ""
        
        viewModel.sendMoney()
        
        XCTAssertEqual(viewModel.transferMessage, "Please enter recipient and amount.")
    }
    
    func testSuccessfulTransfer() async {
        let fakeAPI = APIFake()
        let viewModel = MoneyTransferViewModel(api: fakeAPI)
        
        viewModel.recipient = "test@email.com"
        viewModel.amount = "50.5"
        
        let expectation = XCTestExpectation(description: "Transfer completes")
        
        Task {
            viewModel.sendMoney()
            try! await Task.sleep(nanoseconds: 100_000_000)
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 2.0)
        
        XCTAssertEqual(viewModel.transferMessage, "Successfully transferred 50.5 to test@email.com")
    }

    func testFailedTransfer() async {
        let fakeAPI = APIFake()
        fakeAPI.shouldSucceed = false
        let viewModel = MoneyTransferViewModel(api: fakeAPI)
        
        viewModel.recipient = "test@email.com"
        viewModel.amount = "50.5"
        
        let expectation = XCTestExpectation(description: "Transfer completes")
        
        Task {
            viewModel.sendMoney()
            try! await Task.sleep(nanoseconds: 100_000_000)
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 2.0)
        
        XCTAssertFalse(viewModel.alertMessage.isEmpty)
        XCTAssertTrue(viewModel.showAlert)
    }
}
