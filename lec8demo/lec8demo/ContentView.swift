//
//  ContentView.swift
//  lec8demo
//
//  Created by Andy Huang on 10/26/23.
//

import SwiftUI
import GoogleSignInSwift
import GoogleSignIn

struct ContentView: View {
    @StateObject var authViewModel: AuthenticationViewModel = AuthenticationViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
                VStack {
                    Button("Sign in with email and password") {
                        signInWithEmailPassword()
                    }
                    .padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    
                    Button("Sign up with email and password") {
                        signUpWithEmailPassword()
                    }
                    .padding()
                    .background(.red)
                    .foregroundStyle(.white)
                    .padding()
                    
                    GoogleSignInButton(action: signInWithGoogle)
                        .padding(.horizontal, 50)
                }
                .navigationTitle("Sign In")
        }
    }
    
    private func signUpWithEmailPassword() {
        Task {
          if await authViewModel.signUpWithEmailPassword() == true {
            dismiss()
          }
        }
    }
    
    private func signInWithEmailPassword() {
      Task {
        if await authViewModel.signInWithEmailPassword() == true {
          dismiss()
        }
      }
    }

    private func signInWithGoogle() {
      Task {
        if await authViewModel.signInWithGoogle() == true {
          dismiss()
        }
      }
    }
}

#Preview {
    ContentView()
}
