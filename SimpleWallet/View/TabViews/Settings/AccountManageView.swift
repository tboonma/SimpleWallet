//
//  AccountManageView.swift
//  SimpleWallet
//
//  Created by Tawan Boonma on 12/5/2567 BE.
//

import SwiftUI

struct AccountManageView: View {
    var wallet: Wallet?
    var onSaved: (() -> ())?
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var accountName = ""
    @State private var startingBalance = 0.0
    @State private var selectedCategory: WalletCategory = .wallet
    @State private var selectedColor = Color.red
    @State private var selectedIcon: String = "person.fill"
    let colors: [Color] = [.red, .green, .blue, .yellow, .orange, .purple, .pink, .cyan, .teal, .indigo, .gray, .brown, .black]
    let icons: [String] = [
            "person.fill",
            "house.fill",
            "car.fill",
            "cart.fill",
            "creditcard.fill",
            "dollarsign.circle.fill",
            "gift.fill",
            "heart.fill",
            "bicycle",
            "book.fill",
            "briefcase.fill",
            "building.fill",
            "globe",
            "music.note",
            "paperplane.fill",
            "phone.fill",
            "bag.fill",
            "star.fill",
            "suitcase.fill"
        ]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("General")) {
                    TextField("Account Name", text: $accountName)
                    TextField("Starting Balance", value: $startingBalance, formatter: numberFormatter)
                        .keyboardType(.decimalPad)
                    Picker("Account Type", selection: $selectedCategory) {
                        ForEach(WalletCategory.allCases, id: \.self) { category in
                            Text(category.rawValue)
                        }
                    }
                    HStack {
                        Text("Color")
                        Spacer()
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(colors, id: \.self) { color in
                                    Button(action: {
                                        selectedColor = color
                                    }) {
                                        Circle()
                                            .fill(color)
                                            .frame(width: 30, height: 30)
                                            .padding(.horizontal, 5)
                                            .overlay(
                                                selectedColor == color ? Image(systemName: "checkmark.circle.fill").foregroundColor(.white) : nil
                                            )
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                        }
                    }
                    
                    Picker("Icon", selection: $selectedIcon) {
                        ForEach(icons, id: \.self) { icon in
                            Label {
                                Image(systemName: icon)
                                    .font(.system(size: 20))
                            } icon: {
                            }
                            .tag(icon)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                if ableToDelete {
                    Section(header: Text("Actions")) {
                        Button("Delete Account") {
                            // Add delete account logic here
                            Task {
                                if wallet == nil {
                                    return
                                }
                                await viewModel.deleteWallet(walletId: (wallet?._id)!)
                                dismiss()
                            }
                        }
                        .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Manage Account")
            .navigationBarItems(trailing: Button("Save") {
                // Add save account logic here
                Task {
                    if wallet != nil {
                        try await viewModel.createWallet(wallet: Wallet(id: NSUUID().uuidString, userId: viewModel.currentUser?.id ?? "", name: accountName, category: selectedCategory.rawValue, startingBalance: startingBalance, iconName: selectedIcon, color: ColorMapping.colorToString[selectedColor] ?? "", dateAdded: .now, lastUpdated: .now))
                    } else {
                        try await viewModel.updateWallet(wallet: Wallet(id: (wallet?.id)!, userId: viewModel.currentUser?.id ?? "", name: accountName, category: selectedCategory.rawValue, startingBalance: startingBalance, iconName: selectedIcon, color: ColorMapping.colorToString[selectedColor] ?? "", dateAdded: .now, lastUpdated: .now))
                    }
                    dismiss()
                }
            }
                .disabled(!readyToSave))
            
        }
        .onAppear(perform: {
            if let wallet {
                accountName = wallet.name
                startingBalance = wallet.startingBalance
                selectedCategory = wallet.rawCategory ?? .wallet
            }
        })
    }
    
    var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        
        return formatter
    }
    
    var readyToSave: Bool {
        !accountName.isEmpty
    }
    
    var ableToDelete: Bool {
        wallet != nil
    }
}

#Preview {
    AccountManageView(wallet: Wallet.MOCK_WALLET)
}
