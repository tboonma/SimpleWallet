//
//  IntroScreen.swift
//  SimpleWallet
//
//  Created by Tawan Boonma on 9/5/2567 BE.
//

import SwiftUI

struct IntroScreen: View {
    // Visibility Status
    @AppStorage("isFirstTime") private var isFirstTime: Bool = true
    var body: some View {
        VStack(spacing: 30) {
            Text("Welcome to SimpleWallet")
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
            
            // Points View
            VStack(alignment: .leading, spacing: 25, content: {
                PointView(symbol: "dollarsign", title: "Transactions", subTitle: "Track your income and expenses at ease.")
                
                PointView(symbol: "chart.bar.fill", title: "Visual Charts", subTitle: "View your transactions using eye-catching graphic representation.")
                
                PointView(symbol: "magnifyingglass", title: "Advance Filters", subTitle: "Find the expenses you want by advance search and filtering.")
            })
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 25)
            
            Spacer(minLength: 1)
            
            Button(action: {
                isFirstTime = false
            }, label: {
                Text("Continue")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(.white)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .padding(.vertical, 14)
                    .background(appTint.gradient, in: .rect(cornerRadius: 12))
                    .contentShape(.rect)
            })
        }
        .padding(15)
        .padding(.top, 20)
    }
    
    // Point View
    @ViewBuilder
    func PointView(symbol: String, title: String, subTitle: String) -> some View {
        HStack(spacing: 15, content: {
            Image(systemName: symbol)
                .font(.largeTitle)
                .foregroundStyle(appTint.gradient)
                .frame(width: 45)
            
            VStack(alignment: .leading, spacing: 6, content: {
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Text(subTitle)
                    .foregroundStyle(.gray)
            })
        })
    }
}

#Preview {
    IntroScreen()
}
