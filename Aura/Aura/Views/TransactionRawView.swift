//
//  TransactionRawView.swift
//  Aura
//
//  Created by Thibault Giraudon on 05/03/2025.
//

import SwiftUI

struct TransactionRawView: View {
    var transaction: Transaction
    var body: some View {
        HStack {
            Image(systemName: transaction.value > 0.0 ? "arrow.up.right.circle.fill" : "arrow.down.left.circle.fill")
                .foregroundColor(transaction.value > 0 ? .green : .red)
            Text(transaction.label)
            Spacer()
            Text("\(transaction.value > 0 ? "+" : "")\(transaction.value, specifier: "%.2f")")
                .fontWeight(.bold)
                .foregroundColor(transaction.value > 0 ? .green : .red)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
        .padding([.horizontal])
    }
}

#Preview {
    TransactionRawView(transaction: Transaction(label: "IKEA", value: -56.4))
}
