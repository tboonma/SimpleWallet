//
//  Constants.swift
//  SimpleWallet
//
//  Created by Tawan Boonma on 9/5/2567 BE.
//

import SwiftUI

let appTint: Color = .blue

extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}

struct CustomColor {
    static var darkGray = Color(hex: 0x161719)
    static var gray = Color(hex: 0xABABAB)
    static var veryPaleGreen = Color(hex: 0xF5FFE7)
    static var Violet = Color(hex: 0x7F3DFF)
}
