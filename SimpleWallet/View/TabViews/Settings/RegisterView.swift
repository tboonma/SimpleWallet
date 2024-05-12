//
//  RegisterView.swift
//  SimpleWallet
//
//  Created by Tawan Boonma on 12/5/2567 BE.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.dismiss) var dismiss
    @State private var email = ""
    @State private var userName = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @EnvironmentObject var viewModel: ViewModel
    @State private var errorMsg = ""

    var body: some View {
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
                    .autocorrectionDisabled(true)
                
                InputView(text: $userName, title: "Username", placeholder: "JohnD")
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .autocorrectionDisabled(true)
                
                InputView(text: $password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                
                ZStack(alignment: .trailing) {
                    InputView(text: $confirmPassword, title: "Password", placeholder: "Confirm your password", isSecureField: true)
                    
                    if !password.isEmpty && !confirmPassword.isEmpty {
                        if password == confirmPassword {
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundStyle(.green)
                        } else {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            // Sign in button
            Button(action: {
                errorMsg = ""
                Task {
                    try await viewModel.createUser(withEmail: email, password: password, userName: userName, onFailed: {
                        errorMsg = $0
                    })
                }
            }, label: {
                HStack {
                    Text("REGISTER")
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
            
            Button {
                dismiss()
            } label: {
                HStack {
                    Text("Already have an account?")
                    Text("Sign in")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
                .font(.system(size: 16))
            }
        }
    }
}

extension RegisterView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty && email.contains("@") && !password.isEmpty && password.count > 5 && password == confirmPassword && !userName.isEmpty
    }
}

#Preview {
    RegisterView()
}
