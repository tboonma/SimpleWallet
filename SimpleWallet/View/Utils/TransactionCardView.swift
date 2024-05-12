//
//  TransactionCardView.swift
//  SimpleWallet
//
//  Created by Tawan Boonma on 11/5/2567 BE.
//

import SwiftUI
import SwiftData

struct TransactionCardView: View {
    @Environment(\.modelContext) private var context
    var transaction: Transaction
    var body: some View {
        SwipeAction(cornerRadius: 10, direction: .trailing) {
            HStack(spacing: 12) {
                Image(systemName: transaction.rawTxnCategory.icon)
                    .fontWeight(.semibold)
                    .frame(width: 45, height: 45)
                    .background(transaction.color.gradient, in: .circle)
                    .foregroundStyle(.white)
                
                VStack(alignment: .leading, spacing: 4, content: {
                    Text(transaction.title)
                        .foregroundStyle(Color.primary)
                    
                    Text(transaction.remarks)
                        .font(.caption)
                        .foregroundStyle(Color.secondary)
                    
                    Text(format(date: transaction.dateAdded, format: "dd MMM yyyy"))
                        .font(.caption2)
                        .foregroundStyle(.gray)
                })
                .lineLimit(1)
                .hSpacing(.leading)
                
                Text(currencyString(transaction.amount, allowedDigits: 2))
                    .fontWeight(.semibold)
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background(.background, in: .rect(cornerRadius: 10))
        } actions: {
            Action(tint: .red, icon: "trash") {
                context.delete(transaction)
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Transaction.self, configurations: config)
    
    let sampleTransaction = Transaction(title: "Test", remarks: "Description", amount: 0.0, dateAdded: .now, category: .income, tintColor: tints.randomElement()!)
    return TransactionCardView(transaction: sampleTransaction).modelContainer(container)
}
