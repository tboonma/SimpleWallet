//
//  PlannedPaymentCardView.swift
//  SimpleWallet
//
//  Created by Tawan Boonma on 13/5/2567 BE.
//

import SwiftUI

struct PlannedPaymentCardView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.dismiss) private var dismiss
    var plannedPayment: PlannedPaymentModel
    var body: some View {
        SwipeAction(cornerRadius: 10, direction: .trailing) {
            HStack(spacing: 12) {
                Image(systemName: plannedPayment.rawExpenseCategory?.icon ?? "")
                    .fontWeight(.semibold)
                    .frame(width: 45, height: 45)
                    .background(plannedPayment.rawColor?.value.gradient ?? appTint.gradient, in: .circle)
                    .foregroundStyle(.white)
                
                VStack(alignment: .leading, spacing: 4, content: {
                    Text(plannedPayment.paymentName)
                        .foregroundStyle(Color.primary)
                    
                    Text(format(date: plannedPayment.date, format: "dd MMM yyyy"))
                        .font(.caption2)
                        .foregroundStyle(.gray)
                })
                .lineLimit(1)
                .hSpacing(.leading)
                
                Text(currencyString(plannedPayment.amount, allowedDigits: 2))
                    .fontWeight(.semibold)
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background(.background, in: .rect(cornerRadius: 10))
        } actions: {
            Action(tint: .red, icon: "trash") {
                Task {
                    await viewModel.deletePlannedPayment(plannedPaymentId: plannedPayment._id!)
                    dismiss()
                }
            }
        }
    }
}

//#Preview {
//    PlannedPaymentCardView()
//}
