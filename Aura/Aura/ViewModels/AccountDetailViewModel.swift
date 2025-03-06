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
        Transaction(label: "Starbucks", value: -5.50),
        Transaction(label: "Amazon Purchase", value: -34.99),
        Transaction(label: "Salary", value: 2500.00)
    ]
}
