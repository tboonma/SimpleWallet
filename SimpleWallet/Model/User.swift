//
//  Account.swift
//  SimpleWallet
//
//  Created by Tawan Boonma on 12/5/2567 BE.
//

import Foundation


struct User: Identifiable, Codable {
    // Properties
    var id: String
    var userName: String
    var email: String
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: userName) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}

extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, userName: "John Doe", email: "john.doe@gmail.com")
}
