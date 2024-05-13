//
//  Settings.swift
//  SimpleWallet
//
//  Created by Tawan Boonma on 9/5/2567 BE.
//

import SwiftUI
import SwiftData

struct Settings: View {
    // User Properties
    @AppStorage("isNotLoggedIn") private var isNotLoggedIn: Bool = false
    @AppStorage("userName") private var userName: String = ""
    @AppStorage("isAppLockEnabled") private var isAppLockEnabled: Bool = false
    @AppStorage("lockWhenAppGoesBackground") private var lockWhenAppGoesBackground: Bool = false
    @EnvironmentObject var viewModel: ViewModel
    @State var isAccountSettingPresented = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        Text(viewModel.currentUser?.initials ?? "")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(width: 72, height: 72)
                            .background(.gray)
                            .clipShape(.circle)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(viewModel.currentUser?.userName ?? "")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            
                            Text(viewModel.currentUser?.email ?? "")
                                .font(.footnote)
                                .accentColor(.gray)
                        }
                        .foregroundStyle(.black)
                    }
                }
                .contentShape(.rect)
                .onTapGesture {
                    isAccountSettingPresented = true
                }
                .sheet(isPresented: $isAccountSettingPresented, content: {
                    Button {
                        viewModel.signOut(onSuccess: {
                            isAccountSettingPresented = false
                            isNotLoggedIn = true
                        })
                    } label: {
                        Image(systemName: "arrow.left.circle.fill")
                        Text("Sign out")
                    }
                })
                
                NavigationLink {
                    AccountsView()
                } label: {
                    Image(systemName: "book.pages.fill")
                        .fontWeight(.semibold)
                        .foregroundStyle(CustomColor.darkGray)
                    Text("Accounts")
                }
                
            }
            .navigationTitle("Settings")
            .background(.gray.opacity(0.15))
        }
    }
}

#Preview {
    @StateObject var viewModel = ViewModel()
    return Settings().environmentObject(viewModel)
}
