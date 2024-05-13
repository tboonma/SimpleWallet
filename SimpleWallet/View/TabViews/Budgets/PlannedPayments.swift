//
//  PlannedPayments.swift
//  SimpleWallet
//
//  Created by Tawan Boonma on 13/5/2567 BE.
//

import SwiftUI
import SwiftData

struct PlannedPayments: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.dismiss) private var dismiss
    var plannedPayment: PlannedPaymentModel?
    @State private var paymentName = ""
    @State private var selectedAccount: Wallet = Wallet.MOCK_WALLET
    @State private var selectedCategory: ExpenseCategory = .foodAndDrinks
    @State private var date = Date()
    @State private var isRepeating = false
    @State private var repeatFrequency = 0 // 0: Day, 1: Week, 2: Month, 3: Year
    @State private var repeatEndDate = Date()
    @State private var amount = 0.0

    var body: some View {
        Form {
            Section(header: Text("Amount")) {
                TextField("0.0", value: $amount, formatter: numberFormatter)
                    .keyboardType(.decimalPad)
                    .font(.system(size: 24, weight: .bold))
                    .padding(.vertical, 15)
            }
           
            Section(header: Text("Payment Details")) {
                TextField("Payment Name", text: $paymentName)
                
                Picker("Account", selection: $selectedAccount) {
                    ForEach(viewModel.wallets, id: \.self) { wallet in
                        Text(wallet.name)
                    }
                }
                
                Picker("Category", selection: $selectedCategory) {
                    ForEach(ExpenseCategory.allCases, id: \.self) { category in
                        Text(category.rawValue)
                    }
                }
                
                DatePicker("Start Date", selection: $date, displayedComponents: .date)
                
                Toggle("Repeat", isOn: $isRepeating)
                
                if isRepeating {
                    Picker("Repeat Frequency", selection: $repeatFrequency) {
                        Text("Day").tag(0)
                        Text("Week").tag(1)
                        Text("Month").tag(2)
                        Text("Year").tag(3)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    DatePicker("Repeat End Date", selection: $repeatEndDate, displayedComponents: .date)
                }
            }
            
            Section {
                Button("Save") {
                    print(selectedCategory)
                    // Add save logic here
                    Task {
                        if plannedPayment != nil {
                            await viewModel.updatePlannedPayments(paymentModel: PlannedPaymentModel(id: plannedPayment?.id ?? "", userId: viewModel.currentUser?.id ?? "", paymentName: paymentName, selectedAccountId: selectedAccount.id, selectedAccountName: selectedAccount.name, date: date, isRepeating: isRepeating, repeatFrequency: repeatFrequency, repeatEndDate: repeatEndDate, expenseCategory: selectedCategory.rawValue, amount: amount))
                        } else {
                            await viewModel.createPlannedPayment(paymentModel: PlannedPaymentModel(id: NSUUID().uuidString, userId: viewModel.currentUser?.id ?? "", paymentName: paymentName, selectedAccountId: selectedAccount.id, selectedAccountName: selectedAccount.name, date: date, isRepeating: isRepeating, repeatFrequency: repeatFrequency, repeatEndDate: repeatEndDate, expenseCategory: selectedCategory.rawValue, amount: amount))
                        }
                    }
                    dismiss()
                }
                
                if ableToDelete {
                    Button("Delete") {
                        // Add delete logic here
                        Task {
                            await viewModel.deletePlannedPayment(plannedPaymentId: (plannedPayment?._id)!)
                            dismiss()
                        }
                    }
                    .foregroundColor(.red)
                }
            }
        }
        .navigationTitle("Planned Payments")
        .onAppear(perform: {
            viewModel.getWallet()
            
            if plannedPayment != nil {
                paymentName = plannedPayment?.paymentName ?? ""
                if plannedPayment?.selectedAccountId != nil {
                    let actualWallet = viewModel.wallets.first(where: { $0.id == plannedPayment?.selectedAccountId })
                    if actualWallet != nil {
                        selectedAccount = actualWallet!
                    }
                }
                if plannedPayment?.expenseCategory != nil {
                    selectedCategory = plannedPayment?.rawExpenseCategory ?? .foodAndDrinks
                }
                date = plannedPayment?.date ?? .now
                isRepeating = plannedPayment?.isRepeating ?? false
                repeatFrequency = plannedPayment?.repeatFrequency ?? 0
                repeatEndDate = plannedPayment?.repeatEndDate ?? .now
                amount = plannedPayment?.amount ?? 0.0
            }
        })
    }
    
    var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        
        return formatter
    }
    
    var ableToDelete: Bool {
        return plannedPayment != nil
    }
}

#Preview {
    PlannedPayments()
}
