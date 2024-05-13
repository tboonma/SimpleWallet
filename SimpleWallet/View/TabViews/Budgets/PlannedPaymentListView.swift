//
//  PlannedPaymentListView.swift
//  SimpleWallet
//
//  Created by Tawan Boonma on 13/5/2567 BE.
//

import SwiftUI

struct PlannedPaymentListView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var isAddingPayment = false
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(spacing: 10) {
                    Section {
                        ForEach(viewModel.plannedPayments) { payment in
                            NavigationLink {
                                PlannedPayments(plannedPayment: payment)
                            } label: {
                                TransactionCardView(transaction: Transaction(id: payment.id, userId: "", title: payment.paymentName, remarks: "", amount: payment.amount, dateAdded: payment.date, category: .expense, tintColor: payment.rawColor ?? TintColor(color: "Blue", value: .blue), txnCategory: payment.rawExpenseCategory ?? .others))
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(.horizontal, 15)
            }
            .background(.gray.opacity(0.15))
                
        }
        .navigationTitle("Planned Payments")
        .navigationBarItems(trailing: Button(action: {
            isAddingPayment = true
        }) {
            Image(systemName: "plus")
                .font(.caption)
                .foregroundStyle(.white)
                .padding(10)
                .background(Color.blue)
                .clipShape(Circle())
        })
        .sheet(isPresented: $isAddingPayment, content: {
            PlannedPayments()
        })
        .onAppear {
            viewModel.getPlannedPayments()
        }
    }
}

#Preview {
    PlannedPaymentListView()
}
