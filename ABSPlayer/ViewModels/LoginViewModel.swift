//
//  LoginViewModel.swift
//  ABSPlayer
//
//  Created by Simon Helming on 26.10.24.
//
import SwiftUI
import Combine

import Audiobookshelf

class LoginViewModel: ObservableObject {
    @Published var serverAddress: String = ""
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var loginError: String?

    private let audiobookshelfService = AudiobookshelfService.shared    
    init() {
        serverAddress = self.audiobookshelfService.getServerAddress()
        if let usernameData = KeychainService.load(key: "username") {
            username = String(data: usernameData, encoding: .utf8) ?? ""
        }
        if let passwordData = KeychainService.load(key: "password") {
            password = String(data: passwordData, encoding: .utf8) ?? ""
        }
    }

    func login() {
        // Validiere Eingaben
        guard !serverAddress.isEmpty, !username.isEmpty, !password.isEmpty else {
            loginError = "Bitte alle Felder ausfüllen."
            return
        }
        
        // Setze die Serveradresse und rufe den Login auf
        audiobookshelfService.setServerAddress(serverAddress)
        Task {
            let result = await self.audiobookshelfService.login(username: username, password: password)
            DispatchQueue.main.async {
                if result {
                    self.isLoggedIn = true
                } else {
                    self.loginError = "Login fehlgeschlagen."
                }
            }
        }
        
    }
}
