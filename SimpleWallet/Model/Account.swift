//
//  Account.swift
//  SimpleWallet
//
//  Created by Tawan Boonma on 12/5/2567 BE.
//

import SwiftUI
import SwiftData

@Model
class Account {
    // Properties
    var userName: String
    var email: String
    var password: String?
    
    init(userName: String, email: String, password: String? = nil) {
        self.userName = userName
        self.email = email
        self.password = password
    }
}
