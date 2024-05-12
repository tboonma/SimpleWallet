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

enum WalletCategory: String, CaseIterable, Codable {
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
    
    var icon: String {
        get {
            if self == .foodAndDrinks {
                return "fork.knife"
            }
            else if self == .shopping {
                return "bag"
            }
            else if self == .transportation {
                return "cablecar"
            }
            else if self == .housing {
                return "house"
            }
            else if self == .vehicle {
                return "car"
            }
            else if self == .entertainment {
                return "figure.play"
            }
            else if self == .investments {
                return "chart.line.uptrend.xyaxis"
            }
            else if self == .publicUtilities {
                return "globe.asia.australia.fill"
            }
            else if self == .others {
                return "ellipsis.circle"
            }
            return ""
        }
        set {}
    }
}

enum IncomeCategory: String, CaseIterable {
    case salary = "Salary"
    case sale = "Sale"
    case taxRefund = "Tax Refunds"
    case gifts = "Gifts"
    case income = "Income"
    
    var icon: String {
        get {
            if self == .salary {
                return "line.horizontal.3"
            }
            else if self == .sale {
                return "line.horizontal.3"
            }
            else if self == .taxRefund {
                return "line.horizontal.3"
            }
            else if self == .gifts {
                return "line.horizontal.3"
            }
            else if self == .income {
                return "line.horizontal.3"
            }
            return ""
        } set {}
    }
}
