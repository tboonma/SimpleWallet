//
//  LoginView.swift
//  SimpleWallet
//
//  Created by Tawan Boonma on 12/5/2567 BE.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: ViewModel
    @State private var errorMsg = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                // Image
                Image("SimpleWallet-Logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 140)
                    .padding(.vertical, 32)
                
                // Form fields
                VStack(spacing: 24) {
                    InputView(text: $email, title: "Email Address", placeholder: "john.doe@gmail.com")
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    
                    InputView(text: $password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                // Sign in button
                Button(action: {
                    errorMsg = ""
                    Task {
                        try await viewModel.signIn(withEmail: email, password: password, onFailed: {
                            errorMsg = $0
                        })
                    }
                }, label: {
                    HStack {
                        Text("SIGN IN")
                            .fontWeight(.semibold)
                        
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                })
                .background(appTint)
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                .cornerRadius(10)
                .padding(.top, 24)
                
                Text(errorMsg)
                    .foregroundStyle(.red)
                
                Spacer()
                
                // Sign up button
                NavigationLink {
                    RegisterView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack {
                        Text("Don't have an account?")
                        Text("Sign up")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                    .font(.system(size: 16))
                }
            }
        }
    }
}

extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty && email.contains("@") && !password.isEmpty && password.count > 5
    }
}

#Preview {
    LoginView()
}
