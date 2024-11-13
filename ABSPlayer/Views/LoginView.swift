//
//  LoginView.swift
//  ABSPlayer
//
//  Created by Simon Helming on 26.10.24.
//

import SwiftUI

struct LoginView: View {
        @StateObject private var viewModel = LoginViewModel()
        
        var body: some View {
            VStack(spacing: 20) {
                Text("Audiobookshelf Login")
                    .font(.largeTitle)
                    .padding(.bottom, 20)
                
                TextField("Server-Adresse", text: $viewModel.serverAddress)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                
                TextField("Benutzername", text: $viewModel.username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                
                SecureField("Passwort", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                if let error = viewModel.loginError {
                    Text(error)
                        .foregroundColor(.red)
                }
                
                Button(action: {
                    viewModel.login()
                }) {
                    Text("Login")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            .padding()
            .fullScreenCover(isPresented: $viewModel.isLoggedIn) {
                // Zeige den Hauptbildschirm oder eine andere Ansicht nach dem erfolgreichen Login
                LibraryView()
            }
        }
}

#Preview {
    LoginView()
}
