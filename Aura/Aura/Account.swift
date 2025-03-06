//
//  Account.swift
//  Aura
//
//  Created by Thibault Giraudon on 05/03/2025.
//

import Foundation

struct Transaction: Codable {
    var label: String
    var value: Double
}

struct Account: Codable {
    var currentBalance: Double
    var transactions: [Transaction]
    
    
    init() {
        currentBalance = 0.0
        transactions = []
    }
}
