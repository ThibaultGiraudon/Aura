//
//  ContentView.swift
//  Aura
//
//  Created by Thibault Giraudon on 05/03/2025.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = AppViewModel()
    var body: some View {
        Group {
            if viewModel.isLogged {
                TabView {
                    AccountDetailView(viewModel: viewModel.accountDetailViewModel)
                        .tabItem {
                            Image(systemName: "person.crop.circle")
                            Text("Account")
                        }
                    
                    MoneyTransferView()
                        .tabItem {
                            Image(systemName: "arrow.right.arrow.left.circle")
                            Text("Transfer")
                        }
                }
                
            } else {
                AuthenticationView(viewModel: viewModel.authenticationViewModel)
                    .transition(.asymmetric(insertion: .move(edge: .trailing).combined(with: .opacity),
                                            removal: .move(edge: .top).combined(with: .opacity)))
                
            }
        }
        .accentColor(Color(hex: "#94A684"))
        .animation(.easeInOut(duration: 0.5), value: UUID())
    }
}

#Preview {
    ContentView()
}
