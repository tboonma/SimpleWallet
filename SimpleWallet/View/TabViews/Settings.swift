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
    @AppStorage("userName") private var userName: String = ""
    @AppStorage("isAppLockEnabled") private var isAppLockEnabled: Bool = false
    @AppStorage("lockWhenAppGoesBackground") private var lockWhenAppGoesBackground: Bool = false
    @EnvironmentObject var viewModel: AuthViewModel
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
                        })
                    } label: {
                        Image(systemName: "arrow.left.circle.fill")
                        Text("Sign out")
                    }
                })
                
                NavigationLink {
                    
                } label: {
                    Image(systemName: "gearshape.fill")
                        .fontWeight(.semibold)
                        .foregroundStyle(CustomColor.darkGray)
                    Text("Accounts")
                    
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

//#Preview {
//    @StateObject var viewModel = AuthViewModel()
//    return Settings().environmentObject(viewModel)
//}
