//
//  Account.swift
//  Aura
//
//  Created by Thibault Giraudon on 05/03/2025.
//

import Foundation


struct Account: Codable {
    var currentBalance: Double
    var transactions: [Transaction]
    
    struct Transaction: Codable {
        var label: String
        var value: Double
    }
    
    init() {
        currentBalance = 0.0
        transactions = []
    }
}
