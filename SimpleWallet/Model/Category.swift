//
//  Category.swift
//  SimpleWallet
//
//  Created by Tawan Boonma on 9/5/2567 BE.
//

import SwiftUI

enum Category: String, CaseIterable {
    case income = "Income"
    case expense = "Expense"
}

enum WalletCategory: String, CaseIterable {
    case wallet = "Wallet"
    case card = "Card"
    case creditCard = "Credit Card"
}

enum ExpenseCategory: String, CaseIterable {
    case foodAndDrinks = "Food & Drinks"
    case shopping = "Shopping"
    case transportation = "Transportation"
    case housing = "Housing"
    case vehicle = "Vehicle"
    case entertainment = "Entertainment"
    case investments = "Investments"
    case publicUtilities = "Public Utilities"
    case others = "Others"
    
    @ViewBuilder
    var itemContent: some View {
        switch self {
        case .foodAndDrinks:
            Image(systemName: "fork.knife")
            Text(self.rawValue)
        case .shopping:
            Image(systemName: "bag")
            Text(self.rawValue)
        case .transportation:
            Image(systemName: "cablecar")
            Text(self.rawValue)
        case .housing:
            Image(systemName: "house")
            Text(self.rawValue)
        case .vehicle:
            Image(systemName: "car")
            Text(self.rawValue)
        case .entertainment:
            Image(systemName: "figure.play")
            Text(self.rawValue)
        case .investments:
            Image(systemName: "chart.line.uptrend.xyaxis")
            Text(self.rawValue)
        case .publicUtilities:
            Image(systemName: "globe.asia.australia.fill")
            Text(self.rawValue)
        case .others:
            Image(systemName: "ellipsis.circle")
            Text(self.rawValue)
        }
    }
}
