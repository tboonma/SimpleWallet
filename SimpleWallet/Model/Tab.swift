//
//  Tab.swift
//  SimpleWallet
//
//  Created by Tawan Boonma on 9/5/2567 BE.
//

import SwiftUI

enum Tab: String {
    case home = "Home"
    case transactions = "Transactions"
    case budgets = "Budgets"
    case settings = "Settings"
    
    @ViewBuilder
    var tabContent: some View {
        switch self {
        case .home:
            Image(systemName: "house.fill")
            Text(self.rawValue)
        case .transactions:
            Image(systemName: "tray.full.fill")
            Text(self.rawValue)
        case .budgets:
            Image(systemName: "dollarsign.circle.fill")
            Text(self.rawValue)
        case .settings:
            Image(systemName: "gearshape")
            Text(self.rawValue)
        }
    }
}
