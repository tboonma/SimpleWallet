//
//  Settings.swift
//  SimpleWallet
//
//  Created by Tawan Boonma on 9/5/2567 BE.
//

import SwiftUI

struct Settings: View {
    // User Properties
    @AppStorage("userName") private var userName: String = ""
    @AppStorage("isAppLockEnabled") private var isAppLockEnabled: Bool = false
    @AppStorage("lockWhenAppGoesBackground") private var lockWhenAppGoesBackground: Bool = false
    var body: some View {
        NavigationStack {
            List {
                Section("User Name") {
                    TextField("John", text: $userName)
                }
                
                
                NavigationLink {
                    
                } label: {
                    Image(systemName: "wallet.pass.fill")
                        .fontWeight(.semibold)
                        .foregroundStyle(CustomColor.darkGray)
                    Text("Account")
                    
                }
                
                NavigationLink {
                    
                } label: {
                    Image(systemName: "gearshape.fill")
                        .fontWeight(.semibold)
                        .foregroundStyle(CustomColor.darkGray)
                    Text("General")
                    
                }
                
                NavigationLink {
                    
                } label: {
                    Image(systemName: "lock.fill")
                        .fontWeight(.semibold)
                        .foregroundStyle(CustomColor.darkGray)
                    Text("Security")
                }
                
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    Settings()
}
