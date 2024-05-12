//
//  CardView.swift
//  SimpleWallet
//
//  Created by Tawan Boonma on 9/5/2567 BE.
//

import SwiftUI

struct CardView: View {
    var income: Double
    var expense: Double
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.background)
            
            VStack(spacing: 0, content: {
                Text("Account Balance").foregroundStyle(CustomColor.gray).fontWeight(.medium)
                HStack(spacing: 12, content: {
                    
                    Text("\(currencyString(income - expense))")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/.bold())
                    
                    Image(systemName: expense > income ? "chart.line.downtrend.xyaxis" : "chart.line.uptrend.xyaxis")
                        .font(.title3)
                        .foregroundStyle(expense > income ? .red : .green)
                }).padding(.bottom, 5)
                
                HStack(spacing: 0, content: {
                    ForEach(Category.allCases, id: \.rawValue) {
                        category in
                        let symbolImage = category == .income ? "arrow.down" : "arrow.up"
                        let tint: Color = category == .income ? .green : .red
                        HStack(spacing: 10) {
                            NavigationLink {
                                if category == .income {
                                    NewTransactionView(category: .income)
                                }
                                else if category == .expense {
                                    NewTransactionView(category: .expense)
                                }
                            } label: {
                                Image(systemName: symbolImage)
                                    .font(.callout.bold())
                                    .foregroundStyle(tint)
                                    .frame(width: 35, height: 35)
                                    .background {
                                        Circle()
                                            .fill(tint.opacity(0.25).gradient)
                                    }
                                
                                VStack(alignment: .leading, spacing: 4, content: {
                                    Text(category.rawValue)
                                        .font(.caption2)
                                        .foregroundStyle(.gray)
                                    
                                    Text(currencyString(category == .income ? income : expense, allowedDigits: 0))
                                        .font(.callout)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.black)
                                })
                                
                                if category == .income {
                                    Spacer(minLength: 10)
                                }
                            }
                        }
                    }
                })
                .padding([.horizontal, .bottom], 25)
                .padding(.top, 20)
            })
            .padding(.top, 20)
        }
        
    }
}

#Preview {
    ContentView()
}
