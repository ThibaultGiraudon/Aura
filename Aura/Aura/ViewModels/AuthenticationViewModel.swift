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
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var showError = false
    private var api: APIProtocol
    
    let onLoginSucceed: (() -> ())
    
    init(_ callback: @escaping () -> (), api: APIProtocol = API.shared) {
        self.onLoginSucceed = callback
        self.api = api
    }
    
    @MainActor
    func login() {
        Task {
            do {
                alertMessage = ""
                if !username.isValidEmail {
                    showError = true
                    alertMessage = "Please enter a valid email."
                    return
                }
                let response: [String: String] = try await api.call(endPoint: API.AuthEndPoints.authenticate(username: username, password: password))
                
                // TODO move in call with type
                                      
                guard let token = response["token"] else {
                    throw API.Error.responseError
                }
                
                API.shared.token = String(token)
                
                onLoginSucceed()
            } catch let error as API.Error where error == .badRequest {
                showError = true
                alertMessage = error.localizedDescription
            } catch {
                showAlert = true
                alertMessage = error.localizedDescription
            }
        }
    }
}
