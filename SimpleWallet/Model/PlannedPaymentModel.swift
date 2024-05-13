//
//  PlannedPaymentModel.swift
//  SimpleWallet
//
//  Created by Tawan Boonma on 13/5/2567 BE.
//

import Foundation
import SwiftData
import FirebaseFirestoreSwift

struct PlannedPaymentModel: Identifiable, Codable {
    @DocumentID var _id: String? // Firestore document ID
    var id: String
    var userId: String
    var paymentName: String
    var selectedAccountId: String
    var selectedAccountName: String
    var date: Date
    var isRepeating: Bool
    var repeatFrequency: Int
    var repeatEndDate: Date
    var expenseCategory: String
    var amount: Double
    var color = tints.randomElement()!.color
    
    var rawExpenseCategory: ExpenseCategory? {
        return ExpenseCategory.allCases.first(where: { expenseCategory == $0.rawValue })
    }
    
    var rawColor: TintColor? {
        return tints.first(where: { $0.color == color })
    }
}

enum RepeatFrequency {
    case day
    case week
    case month
    case year
}
