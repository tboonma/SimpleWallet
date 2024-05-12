//
//  AccountsView.swift
//  SimpleWallet
//
//  Created by Tawan Boonma on 12/5/2567 BE.
//

import SwiftUI

struct AccountsView: View {
    @State private var isAddingAccount = false
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(viewModel.wallets) { wallet in
                        NavigationLink {
                            AccountManageView(wallet: wallet)
                        } label: {
                            Text(wallet.name)
                                .padding(.vertical, 10)
                        }
                    }
                }
            }
            .navigationTitle("Accounts")
            .navigationBarItems(trailing: Button(action: {
                isAddingAccount = true
            }) {
                Image(systemName: "plus")
                    .font(.title3)
                    .foregroundStyle(.white)
                    .padding(10)
                    .background(Color.blue)
                    .clipShape(Circle())
            })
            .sheet(isPresented: $isAddingAccount, content: {
                AccountManageView()
            })
        }
        .onAppear {
            viewModel.getWallet()
        }
        .background(.gray.opacity(0.15))
    }
}

#Preview {
    AccountsView()
}
