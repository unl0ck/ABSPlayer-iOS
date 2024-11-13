//
//  ABSPlayerApp.swift
//  ABSPlayer
//
//  Created by Simon Helming on 25.10.24.
//

import SwiftUI

@main
struct ABSPlayerApp: App {
    @State private var isLoggedIn: Bool = false

    init() {
        if let serverAddress = UserDefaults.standard.string(forKey: SERVER_ADDRESS_KEY) {
            /*Task { [weak self] in
                let reachable = await AudiobookshelfService.shared.ping()
                if reachable {
                    DispatchQueue.main.async { [weak self] in
                        self?._isLoggedIn = State(initialValue: true)
                    }
                }
            }*/

        } else {

        }
        // Überprüfen Sie den Token in der Keychain
        if let tokenData = KeychainService.load(key: "token"),
            let token = String(data: tokenData, encoding: .utf8), !token.isEmpty
        {
            // Token ist vorhanden und nicht leer
            _isLoggedIn = State(initialValue: true)
        } else {
            // Kein Token vorhanden
            _isLoggedIn = State(initialValue: false)
        }
    }
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                LibraryView()
            } else {
                LoginView()
            }
        }
    }
}
