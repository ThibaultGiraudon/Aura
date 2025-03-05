//
//  AuthenticationViewModel.swift
//  Aura
//
//  Created by Vincent Saluzzo on 29/09/2023.
//

import Foundation

class AuthenticationViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    
    let onLoginSucceed: (() -> ())
    
    init(_ callback: @escaping () -> ()) {
        self.onLoginSucceed = callback
    }
    
    func login() {
        Task {
            do {
                let jsonData: [String: String] = try await API.shared.call(endPoint: API.AuthEndPoints.authenticate(username: username, password: password))
                
                guard let token = jsonData["token"] else {
                    print("Can't find token")
                    return
                }
                
                API.shared.token = token
                onLoginSucceed()
            } catch {
                print("Login failed: \(error)")
            }
        }
    }
}
