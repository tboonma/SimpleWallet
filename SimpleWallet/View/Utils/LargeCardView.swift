//
//  LargeCardView.swift
//  SimpleWallet
//
//  Created by Tawan Boonma on 12/5/2567 BE.
//

import SwiftUI

struct LargeCardView: View {
    var title: String
    var description: String
    var iconName: String
    var iconColor: Color = appTint
    var body: some View {
        ZStack {
            HStack(spacing: 12, content: {
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.title2)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(.primary)
                        .padding(.vertical, 2)
                    
                    Text(description)
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundStyle(.secondary)
                        .padding(.vertical, 2)
                }
                
                Spacer()
                
                Image(systemName: "gear")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .padding(15)
                    .background(iconColor)
                    .foregroundStyle(.white)
                    .clipShape(.rect(cornerRadius: 15))
                
            })
            .padding(.vertical, 15)
            .padding(.horizontal, 20)
            .background(.white)
        }
        .cornerRadius(15)
    }
}

#Preview {
    VStack {
        LargeCardView(title: "Test", description: "Description", iconName: "gear", iconColor: .blue)
    }
    .background(.gray.opacity(0.25))
}
