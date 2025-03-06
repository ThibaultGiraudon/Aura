//
//  TransactionRawView.swift
//  Aura
//
//  Created by Thibault Giraudon on 05/03/2025.
//

import SwiftUI

struct TransactionRawView: View {
    var label: String
    var value: String
    var body: some View {
        HStack {
            Image(systemName: value.contains("+") ? "arrow.up.right.circle.fill" : "arrow.down.left.circle.fill")
                .foregroundColor(value.contains("+") ? .green : .red)
            Text(label)
            Spacer()
            Text(value)
                .fontWeight(.bold)
                .foregroundColor(value.contains("+") ? .green : .red)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
        .padding([.horizontal])
    }
}

#Preview {
    TransactionRawView(label: "IKEA", value: "-55.50")
}
