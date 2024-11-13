//
//  AudiobookshelfService.swift
//  AudiobookshelfService
//
//  Created by Simon Helming on 25.10.24.
//
import Foundation
import Audiobookshelf


class AudiobookshelfService {
    static let shared = AudiobookshelfService()
    
    init() {
        AudiobookshelfAPI.apiResponseQueue = .global(qos: .background)
        
        // Überprüfen Sie den Token in der Keychain
        if let tokenData = KeychainService.load(key: "token"),
           let token = String(data: tokenData, encoding: .utf8), !token.isEmpty {
            AudiobookshelfAPI.customHeaders["Authorization"] = " Bearer \(token)"
            
        } else {
        }
        
    }
    func logout() {
    }
    
    func ping() async -> Bool {
        var result = false
        do {
            let response = try await AudiobookshelfServerAPI.ping()
            result = response.success!
        } catch {
            print(error)
        }
        return result
    }
    
    func setToken(_ token: String) {
            AudiobookshelfAPI.customHeaders["Authorization"] = "Bearer \(token)"
            let _ = KeychainService.save(key: TOKEN_KEY, data: token.data(using: .utf8)!)
        }
    
    func setServerAddress(_ url: String) {
        AudiobookshelfAPI.basePath = url
        UserDefaults.standard.set(url, forKey: SERVER_ADDRESS_KEY)
    }
    
    func getServerAddress() -> String {
        if let serverAddress = UserDefaults.standard.string(forKey: SERVER_ADDRESS_KEY) {
            return serverAddress
        }
        return AudiobookshelfAPI.basePath
    }
    
    func login(username: String, password: String) async -> Bool {
        let _ = KeychainService.save(key: USERNAME_KEY, data: username.data(using: .utf8)!)
        let _ = KeychainService.save(key: PASSWORD_KEY, data: password.data(using: .utf8)!)
        do {
            var loginRequest: LoginRequest = .init()
            loginRequest.username = username
            loginRequest.password = password
            let result = try await AudiobookshelfLoginAPI.login(loginRequest: loginRequest)
            let token = result.user?.token ?? ""
            let _ = KeychainService.save(key: TOKEN_KEY, data: token.data(using: .utf8)!)
            AudiobookshelfAPI.customHeaders["Authorization"] = " Bearer \(result.user?.token ?? "")"
            print(result)
        } catch {
            print(error)
            return false
        }
        return true
    }
    
    func getAllLibs() async -> [Library] {
        do {
            let result = try await AudiobookshelfLibrariesAPI.getLibraries()
            return result.libraries ?? []
        } catch {
            print(error)
            return []
        }
    }
    
    func getLibraryItems(id: UUID) async -> [LibraryItemBase] {
        var result: [LibraryItemBase] = []
        do {
            let response = try await AudiobookshelfLibrariesAPI.getLibraryItems(id: id)
            result = response.results ?? []
            
        } catch {
            print(error)
        }
        return result
    }
    
    func getLibraryItem(id: UUID) async -> LibraryItemBase? {
        var result: LibraryItemBase?
        do {
            let response = try await AudiobookshelfLibraryItemAPI.getLibraryItemById(id: id)
            result = response
        } catch {
            print(error)
        }
        return result
    }
        
}

