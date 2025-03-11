//
//  AccountDetailView.swift
//  Aura
//
//  Created by Vincent Saluzzo on 29/09/2023.
//

import SwiftUI

struct AccountDetailView: View {
    @ObservedObject var viewModel: AccountDetailViewModel
    @State private var extend = false
    
    var body: some View {
        VStack(spacing: 20) {
            // Large Header displaying total amount
            VStack(spacing: 10) {
                Text("Your Balance")
                    .font(.headline)
                Group {
                    Text(viewModel.totalAmount)
                        .font(.system(size: 60, weight: .bold))
                    Image(systemName: "eurosign.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 80)
                }
                .foregroundColor(Color(hex: "#94A684"))
            }
            .padding(.top)
            
//             Display recent transactions
            VStack(alignment: .leading, spacing: 10) {
                Text("\(extend ? "All transactions" : "Recent Transactions")")
                    .font(.headline)
                    .padding([.horizontal])
                if extend {
                    ScrollView(showsIndicators: false) {
                        ForEach(viewModel.allTransactions, id: \.description) { transaction in
                            TransactionRawView(label: transaction.description, value: transaction.amount)
                        }
                    }
                } else {
                    ForEach(viewModel.recentTransactions, id: \.description) { transaction in
                        TransactionRawView(label: transaction.description, value: transaction.amount)
                    }
                }
            }
            
//             Button to see details of transactions
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
        .onAppear {
            Task {
                await viewModel.getAccount()
            }
        }
        .alert(viewModel.alertMessage, isPresented: $viewModel.showAlert) {
            Button("OK") {
                viewModel.alertMessage = ""
                viewModel.showAlert = false
            }
        }
    }
        
}

#Preview {
    AccountDetailView(viewModel: AccountDetailViewModel())
}
