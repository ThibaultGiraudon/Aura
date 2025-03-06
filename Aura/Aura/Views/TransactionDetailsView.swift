//
//  TransactionDetailsView.swift
//  Aura
//
//  Created by Thibault Giraudon on 05/03/2025.
//

import SwiftUI

struct TransactionDetailsView: View {
    var transactions: [Transaction]
    var body: some View {
        ScrollView(showsIndicators: false) {
            ForEach(transactions, id: \.label) { transaction in
                TransactionRawView(transaction: transaction)
            }
        }
    }
}

#Preview {
    let transactions = [Transaction(label: "IKEA", value: -56.4)]
    TransactionDetailsView(transactions: transactions)
}
