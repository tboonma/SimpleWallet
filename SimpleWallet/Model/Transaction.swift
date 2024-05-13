//
//  Transaction.swift
//  SimpleWallet
//
//  Created by Tawan Boonma on 9/5/2567 BE.
//

import Foundation
import SwiftUI
import SwiftData
import FirebaseFirestoreSwift

@Model
class Transaction {
    // Properties
    var id: String
    var title: String
    var remarks: String
    var amount: Double
    var dateAdded: Date
    var category: String
    var tintColor: String
    var txnCategory: String
    
    init(id: String, title: String, remarks: String, amount: Double, dateAdded: Date, category: Category, tintColor: TintColor, txnCategory: ExpenseCategory = .foodAndDrinks) {
        self.id = id
        self.title = title
        self.remarks = remarks
        self.amount = amount
        self.dateAdded = dateAdded
        self.category = category.rawValue
        self.tintColor = tintColor.color
        self.txnCategory = txnCategory.rawValue
    }
    
    // Extracting Color Value from tintColor String
    @Transient
    var color: Color {
        return tints.first(where: { $0.color == tintColor })?.value ?? appTint
    }
    
    @Transient
    var tint: TintColor? {
        return tints.first(where: { $0.color == tintColor })
    }
    
    @Transient
    var rawCategory: Category? {
        return Category.allCases.first(where: { category == $0.rawValue })
    }
    
    @Transient
    var rawTxnCategory: ExpenseCategory {
        return ExpenseCategory.allCases.first(where: { txnCategory == $0.rawValue }) ?? .foodAndDrinks
    }
}

struct TransactionModel: Identifiable, Codable {
    @DocumentID var _id: String? // Firestore document ID
    var id: String
    var userId: String
    var title: String
    var remarks: String
    var amount: Double
    var dateAdded: Date
    var category: String
    var tintColor: String
    var txnCategory: String
    
    var color: Color {
        return tints.first(where: { $0.color == tintColor })?.value ?? appTint
    }
    
    var tint: TintColor? {
        return tints.first(where: { $0.color == tintColor })
    }
    
    var rawCategory: Category? {
        return Category.allCases.first(where: { category == $0.rawValue })
    }
    
    var rawTxnCategory: ExpenseCategory {
        return ExpenseCategory.allCases.first(where: { txnCategory == $0.rawValue }) ?? .foodAndDrinks
    }
}
