//
//  AccountDetailView.swift
//  Aura
//
//  Created by Vincent Saluzzo on 29/09/2023.
//

import SwiftUI

struct AccountDetailView: View {
    @State private var account = Account()
    @State private var extend = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack(spacing: 20) {
            // Large Header displaying total amount
            VStack(spacing: 10) {
                Text("Your Balance")
                    .font(.headline)
                Group {
                    Text("\(account.currentBalance, specifier: "%.2f")")
                        .font(.system(size: 60, weight: .bold))
                    Image(systemName: "eurosign.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 80)
                }
                .foregroundColor(account.currentBalance > 0 ? Color(hex: "#94A684") : .red)
            }
            .padding(.top)
            
            // Display recent transactions
            VStack(alignment: .leading, spacing: 10) {
                Text("\(extend ? "All transactions" : "Recent Transactions")")
                    .font(.headline)
                    .padding([.horizontal])
                if extend {
                    ScrollView(showsIndicators: false) {
                        ForEach(account.transactions, id: \.label) { transaction in
                            TransactionRawView(transaction: transaction)
                        }
                    }
                } else {
                    ForEach(account.transactions.prefix(3), id: \.label) { transaction in
                        TransactionRawView(transaction: transaction)
                    }
                }
            }
            
            // Button to see details of transactions
            Button(action: {
                extend.toggle()
            }) {
                HStack {
                    Image(systemName: "list.bullet")
                    Text("\(extend ? "Hide" : "See") Transaction Details")
                }
                .padding()
                .background(Color(hex: "#94A684"))
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .padding([.horizontal, .bottom])
            
            Spacer()
        }
        .onTapGesture {
            self.endEditing(true)  // This will dismiss the keyboard when tapping outside
        }
        .onAppear {
            Task {
                do {
                    let data = try await API.shared.call(endPoint: API.AccountEndPoints.account)
                    account = try JSONDecoder().decode(Account.self, from: data)
                } catch {
                    alertMessage = error.localizedDescription
                    showAlert = true
                }
            }
        }
        .alert(alertMessage, isPresented: $showAlert) {
            Button("OK") {
                alertMessage = ""
                showAlert = false
            }
        }
    }
        
}

#Preview {
    AccountDetailView()
}
