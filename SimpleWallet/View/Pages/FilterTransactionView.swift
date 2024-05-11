//
//  FilterTransactionView.swift
//  SimpleWallet
//
//  Created by Tawan Boonma on 12/5/2567 BE.
//

import SwiftUI
import SwiftData

// Custom View
struct FilterTransactionView<Content: View>: View {
    var content: ([Transaction]) -> Content
    @Query(animation: .snappy) private var transactions: [Transaction]
    init(category: Category?, searchText: String, @ViewBuilder content: @escaping ([Transaction]) -> Content) {
        let rawValue = category?.rawValue ?? ""
        
        // Custom Predicate
        let predicate = #Predicate<Transaction> { transaction in
            return (transaction.title.localizedStandardContains(searchText) || transaction.remarks.localizedStandardContains(searchText)) && (rawValue.isEmpty ? true : transaction.category == rawValue)
        }
        
        _transactions = Query(filter: predicate, sort: [SortDescriptor(\Transaction.dateAdded, order: .reverse)], animation: .snappy)
        
        self.content = content
    }
    
    var body: some View {
        content(transactions)
    }
}
