//
//  Home.swift
//  SimpleWallet
//
//  Created by Tawan Boonma on 9/5/2567 BE.
//

import SwiftUI
import SwiftData

struct Home: View {
    // Data Persistents
    @Query(sort: [SortDescriptor(\Transaction.dateAdded, order: .reverse)], animation: .snappy) private var transactions: [Transaction]
    // User Properties
    @Environment(\.modelContext) private var context
    @AppStorage("userName") private var userName: String = ""
    @EnvironmentObject var viewModel: ViewModel
    // View Properties
    @State private var startDate: Date = .now.startOfMonth
    @State private var endDate: Date = .now.endOfMonth
    @State private var selectedCategory: Category = .income
    private var totalIncome: Double {
        transactions
            .filter({ $0.rawCategory == .income && $0.userId == viewModel.currentUser?.id })
            .reduce(0) { $0 + $1.amount }
    }
    private var totalExpense: Double {
        transactions
            .filter({ $0.rawCategory == .expense && $0.userId == viewModel.currentUser?.id })
            .reduce(0) { $0 + $1.amount }
    }
    // For Animation
    @Namespace private var animation
    
    var body: some View {
        GeometryReader {
            // For Animation Purpose
            let size = $0.size
            
            NavigationStack {
                ScrollView(.vertical) {
                    VStack(spacing: 10, content: {
                        Section {
                            // Card View
                            CardView(income: totalIncome, expense: totalExpense)
                            
                            ForEach(transactions.filter({ $0.userId == viewModel.currentUser?.id }), id: \.self) { transaction in
                                NavigationLink {
                                    NewTransactionView(editTransaction: transaction)
                                } label: {
                                    TransactionCardView(transaction: transaction)
                                }
                                .buttonStyle(.plain)
                            }
                            
                        } header: {
                            HeaderView(size)
                        }
                    })
                    .padding(.horizontal, 15)
                }
                .background(.gray.opacity(0.15))
            }
            .onAppear(perform: {
                viewModel.getTransactions()
            })
        }
    }
    
    // Header View
    @ViewBuilder
    func HeaderView(_ size: CGSize) -> some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 5, content: {
                Text(viewModel.currentUser?.initials ?? "")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 40, height: 40)
                    .background(.gray)
                    .clipShape(.circle)
            })
            
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            
            NavigationLink {
                NewTransactionView()
            } label: {
                Image(systemName: "plus")
                    .font(.caption)
                    .foregroundStyle(.white)
                    .padding(10)
                    .background(Color.blue)
                    .clipShape(Circle())
            }
        }
        .padding(.bottom, 5)
        .background {
            Rectangle()
                .fill(.white)
                .padding(.horizontal, -15)
                .padding(.top, -(safeArea.top + 15))
        }
    }
    
    // Segmented Control
    func CustomSegmentedControl() -> some View {
        HStack(spacing: 0) {
            ForEach(Category.allCases, id: \.rawValue) {
                category in
                Text(category.rawValue)
                    .hSpacing()
                    .padding(.vertical, 10)
                    .background {
                        if category == selectedCategory {
                            Capsule()
                                .fill(.background)
                                .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                        }
                    }
                    .contentShape(.capsule)
                    .onTapGesture {
                        withAnimation(.snappy) {
                            selectedCategory = category
                        }
                    }
            }
        }
        .background(.gray.opacity(0.15), in: .capsule)
        .padding(.top, 5)
    }
}

//#Preview {
//    @StateObject var viewModel = AuthViewModel()
//    return ContentView().environmentObject(viewModel)
//}
