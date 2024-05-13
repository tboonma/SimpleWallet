//
//  NewTransactionView.swift
//  SimpleWallet
//
//  Created by Tawan Boonma on 11/5/2567 BE.
//

import SwiftUI
import SwiftData

struct NewTransactionView: View {
    // Env Properties
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: ViewModel
    var editTransaction: Transaction?
    var editTransaction2: TransactionModel?
    @State var category: Category = .expense
    // View Properties
    @State private var title: String = ""
    @State private var remarks: String = ""
    @State private var amount: Double = .zero
    @State private var dateAdded: Date = .now
    @State private var expenseCategory: ExpenseCategory = .foodAndDrinks
    @State private var incomeCategory: IncomeCategory = .income
    @State private var selectedWallet: Wallet?
    
    // Random Tint
    @State var tint: TintColor = tints.randomElement()!
    // Layout Variables
    @State private var horizontalPadding: CGFloat = 15
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 15) {
                Text("Preview")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .hSpacing(.leading)
                
                // Preview Transaction Card View
                TransactionCardView(transaction: .init(
                    id: "",
                    userId: "",
                    title: title.isEmpty ? "Title" : title,
                    remarks: remarks.isEmpty ? "Remarks" : remarks,
                    amount: amount,
                    dateAdded: dateAdded,
                    category: category,
                    tintColor: tint
                ))
                
                Section(header: Text("Amount").font(.caption)
                    .foregroundStyle(.gray)
                    .hSpacing(.leading)) {
                    HStack {
                        Text(currencySymbol)
                            .font(.callout.bold())
                        TextField("0.0", value: $amount, formatter: numberFormatter)
                            .keyboardType(.decimalPad)
                            .font(.system(size: 24, weight: .bold))
                            .padding(.vertical, 15)
                    }
                    .padding(.horizontal, 15)
                    .background(.background, in: .rect(cornerRadius: 10))
                    .frame(width: 180, height: 180)
                }
                
                WalletSelect()
                
                CustomSection("Title", "iPhone", value: $title)
                
                CategorySelect()
                
                CustomSection("Description", "iPhone 15 Pro Max", value: $remarks)
                
                // Amount & Category Check Box
                VStack(alignment: .leading, spacing: 10, content: {
                    Text("Amount & Category")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .hSpacing(.leading)
                    
                    HStack(spacing: 15) {
                        // Custom Checkbox
                        CategoryCheckbox()
                    }
                })
                
                // Date Picker
                VStack(alignment: .leading, spacing: 10, content: {
                    Text("Date")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .hSpacing(.leading)
                    
                    DatePicker("", selection: $dateAdded, displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(.graphical)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 12)
                        .background(.background, in: .rect(cornerRadius: 10))
                })
            }
            .padding(horizontalPadding)
        }
        .navigationTitle("\(editTransaction == nil ? "New" : "Edit") Transaction")
        .background(.gray.opacity(0.15))
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    Task {
                        await save()
                    }
                }
            }
        })
        .onAppear(perform: {
            viewModel.getWallet()
            
            selectedWallet = viewModel.wallets.first
            
            if let editTransaction {
                // Load all existing data from transaction
                title = editTransaction.title
                remarks = editTransaction.remarks
                dateAdded = editTransaction.dateAdded
                if let category = editTransaction.rawCategory {
                    self.category = category
                }
                amount = editTransaction.amount
                if let tint = editTransaction.tint {
                    self.tint = tint
                }
                
            }
        })
    }
    
    // Saving Date
    func save() async {
        var id = NSUUID().uuidString
        if editTransaction != nil {
            editTransaction?.title = title
            editTransaction?.remarks = remarks
            editTransaction?.amount = amount
            editTransaction?.dateAdded = dateAdded
            editTransaction?.category = category.rawValue
        } else {
            // Saving Item to SwiftData
            let transaction = Transaction(id: id, userId: viewModel.currentUser?.id ?? "", title: title, remarks: remarks, amount: amount, dateAdded: dateAdded, category: category, tintColor: tint)
            context.insert(transaction)
        }
        if editTransaction2 != nil {
            await viewModel.updateTransaction(transaction: TransactionModel(id: editTransaction2?.id ?? "", userId: viewModel.currentUser?.id ?? "", title: title, remarks: remarks, amount: amount, dateAdded: dateAdded, category: category.rawValue, tintColor: tint.color, txnCategory: expenseCategory.rawValue))
        } else {
            await viewModel.createTransaction(transaction: TransactionModel(id: id, userId: viewModel.currentUser?.id ?? "", title: title, remarks: remarks, amount: amount, dateAdded: dateAdded, category: category.rawValue, tintColor: tint.color, txnCategory: expenseCategory.rawValue))
        }
        // Dismissing View
        dismiss()
    }
    
    @ViewBuilder
    func CustomSection(_ title: String, _ hint: String, value: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 10, content: {
            Text(title)
                .font(.caption)
                .foregroundStyle(.gray)
                .hSpacing(.leading)
            
            TextField(hint, text: value)
                .padding(.horizontal, 15)
                .padding(.vertical, 12)
                .background(.background, in: .rect(cornerRadius: 10))
            
        })
    }
    
    // Custom Checkbox
    @ViewBuilder
    func CategoryCheckbox() -> some View {
        HStack(spacing: 10) {
            ForEach(Category.allCases, id: \.rawValue) { category in
                HStack(spacing: 5) {
                    ZStack {
                        Image(systemName: "circle")
                            .font(.title3)
                            .foregroundStyle(appTint)
                        
                        if self.category == category {
                            Image(systemName: "circle.fill")
                                .font(.caption)
                                .foregroundStyle(appTint)
                        }
                    }
                    
                    Text(category.rawValue)
                        .font(.caption)
                }
                .contentShape(.rect)
                .onTapGesture {
                    self.category = category
                }
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 12)
        .hSpacing(.leading)
        .background(.background, in: .rect(cornerRadius: 10))
    }
    
    @ViewBuilder
    func CategorySelect() -> some View {
        VStack(alignment: .leading, spacing: 10, content: {
            Text("Category")
                .font(.caption)
                .foregroundStyle(.gray)
                .hSpacing(.leading)
            
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    if category == .expense {
                        RenderExpenseCategoryStack()
                    } else if category == .income {
                        RenderIncomeCategoryStack()
                    }
                }
                .padding(.horizontal, horizontalPadding)
            }
            .padding(.horizontal, -horizontalPadding)
            .scrollIndicators(.hidden)
        })
    }
    
    func RenderExpenseCategoryStack() -> some View {
        ForEach(ExpenseCategory.allCases, id: \.rawValue) { category in
            HStack {
                Image(systemName: category.icon)
                Text(category.rawValue)
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 5)
            .background(Capsule().fill(expenseCategory == category ? appTint : .white))
            .foregroundStyle(expenseCategory == category ? .white : .primary)
            .onTapGesture {
                expenseCategory = category
            }
        }
    }
    
    func RenderIncomeCategoryStack() -> some View {
        ForEach(IncomeCategory.allCases, id: \.rawValue) { category in
            HStack {
                Image(systemName: category.icon)
                Text(category.rawValue)
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 5)
            .background(Capsule().fill(incomeCategory == category ? appTint : .white))
            .foregroundStyle(incomeCategory == category ? .white : .primary)
            .onTapGesture {
                incomeCategory = category
            }
        }
    }
    
    @ViewBuilder
    func WalletSelect() -> some View {
        VStack(alignment: .leading, spacing: 10, content: {
            Text("Wallet")
                .font(.caption)
                .foregroundStyle(.gray)
                .hSpacing(.leading)
            
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    ForEach(viewModel.wallets, id: \.self) { wallet in
                        HStack {
                            Image(systemName: wallet.iconName)
                            Text(wallet.name)
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 5)
                        .background(Capsule().fill(selectedWallet == wallet ? appTint : .white))
                        .foregroundStyle(selectedWallet == wallet ? .white : .primary)
                        .onTapGesture {
                            selectedWallet = wallet
                        }
                    }
                }
                .padding(.horizontal, horizontalPadding)
            }
            .padding(.horizontal, -horizontalPadding)
            .scrollIndicators(.hidden)
        })
    }
    
    // Number Formatter
    var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        
        return formatter
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Transaction.self, configurations: config)
    return NewTransactionView().modelContainer(container)
}
