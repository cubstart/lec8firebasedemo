//
//  NativeAuthViewModel.swift
//  lec8demo
//
//  Created by Andy Huang on 10/30/23.
//

import Foundation
import Firebase
import GoogleSignIn
import GoogleSignInSwift

class NativeAuthViewModel: ObservableObject {
    @Published var errorMessage: String = ""
    @Published var userIsLoggedIn: Bool = false
    @Published var email: String = "test@gmail.com"
    @Published var password: String = "password123456"
    
    func signInWithEmailPassword() async -> Bool {
        do {
            try await Auth.auth().signIn(withEmail: self.email, password: self.password)
            DispatchQueue.main.async {
                self.userIsLoggedIn = true
            }
            return true
        }
        catch {
            print("User log in failed.")
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
            return false
        }
    }
    
    func signUpWithEmailPassword() async -> Bool {
        do  {
            try await Auth.auth().createUser(withEmail: self.email, password: self.password)
            return true
        }
        catch {
            print(error)
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
            return false
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        }
        catch {
            print(error)
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
