//
//  MoneyTransferViewModel.swift
//  Aura
//
//  Created by Vincent Saluzzo on 29/09/2023.
//

import Foundation

class MoneyTransferViewModel: ObservableObject {
    @Published var recipient: String = ""
    @Published var amount: String = ""
    @Published var transferMessage: String = ""
    @Published var showAlert = false
    @Published var alertMessage = ""
    private var api: APIProtocol
    
    init(api: APIProtocol = API.shared) {
        self.api = api
    }
    
    @MainActor
    func sendMoney() async {
        // Logic to send money - for now, we're just setting a success message.
        // You can later integrate actual logic.
        if !recipient.isEmpty && !amount.isEmpty {
            if !recipient.isValidEmail && !recipient.isValidPhone {
                transferMessage = "Please enter a valid email or phone."
                return
            }
            
            amount = amount.replacingOccurrences(of: ",", with: ".")
            guard let dAmount = Double(amount) else {
                transferMessage = "Please enter a valid amount."
                return
            }
            
            do {
                try await api.call(endPoint: API.AccountEndPoints.transfer(recipient: recipient, amount: dAmount))
                transferMessage = "Successfully transferred \(amount) to \(recipient)"
                
            } catch {
                alertMessage = error.localizedDescription
                showAlert = true
            }
        } else {
            transferMessage = "Please enter recipient and amount."
        }
    }
}
