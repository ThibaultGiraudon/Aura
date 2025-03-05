//
//  AuraApp.swift
//  Aura
//
//  Created by Vincent Saluzzo on 29/09/2023.
//

import SwiftUI

@main
struct AuraApp: App {
    @StateObject var viewModel = AppViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
