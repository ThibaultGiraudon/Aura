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
    
    func testInvalidEmailAndPhone() async {
        viewModel.recipient = "invalid_user"
        viewModel.amount = "100"
        
        await viewModel.sendMoney()
        
        XCTAssertEqual(viewModel.transferMessage, "Please enter a valid email or phone.")
    }

    func testInvalidAmount() async {
        viewModel.recipient = "test@email.com"
        viewModel.amount = "invalid_amount"
        
        await viewModel.sendMoney()
        
        XCTAssertEqual(viewModel.transferMessage, "Please enter a valid amount.")
    }

    func testEmptyFields() async {
        viewModel.recipient = ""
        viewModel.amount = ""
        
        await viewModel.sendMoney()
        
        XCTAssertEqual(viewModel.transferMessage, "Please enter recipient and amount.")
    }
    
    func testSuccessfulTransfer() async {
        let fakeAPI = APIFake()
        let viewModel = MoneyTransferViewModel(api: fakeAPI)
        
        viewModel.recipient = "test@email.com"
        viewModel.amount = "50.5"

        await viewModel.sendMoney()
        
        XCTAssertEqual(viewModel.transferMessage, "Successfully transferred 50.5 to test@email.com")
    }

    func testFailedTransfer() async {
        let fakeAPI = APIFake()
        fakeAPI.shouldSucceed = false
        let viewModel = MoneyTransferViewModel(api: fakeAPI)
        
        viewModel.recipient = "test@email.com"
        viewModel.amount = "50.5"
        
        await viewModel.sendMoney()
                
        XCTAssertFalse(viewModel.alertMessage.isEmpty)
        XCTAssertTrue(viewModel.showAlert)
    }
}
