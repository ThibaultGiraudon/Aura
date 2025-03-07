//
//  AccountDetailViewModel.swift
//  Aura
//
//  Created by Vincent Saluzzo on 29/09/2023.
//

import Foundation

class AccountDetailViewModel: ObservableObject {
    @Published var totalAmount: String = "€12,345.67"
    @Published var recentTransactions: [Transaction] = [
        Transaction(description: "Starbucks", amount: "-€5.50"),
        Transaction(description: "Amazon Purchase", amount: "-€34.99"),
        Transaction(description: "Salary", amount: "+€2,500.00")
    ]
    @Published var allTransactions: [Transaction] = []
    
    @Published var showAlert = false
    @Published var alertMessage = ""
    private var api: APIProtocol
    
    struct Transaction {
        let description: String
        let amount: String
    }
    
    init(api: APIProtocol = API.shared) {
        self.api = api
    }
    
    @MainActor
    func getAccount() {
        Task {
            do {
                let account: Account = try await api.call(endPoint: API.AccountEndPoints.account)
                
                totalAmount = "€" + String(account.currentBalance)
                account.transactions.forEach {
                    let amount = ($0.value > 0 ? "+" : "-") + "€" + String(abs($0.value))
                    allTransactions.append(Transaction(description: $0.label, amount: amount))
                }
                recentTransactions = Array(allTransactions.prefix(3))
            } catch {
                alertMessage = error.localizedDescription
                showAlert = true
            }
        }
    }
}
