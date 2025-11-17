//
//  AtomOneDark.swift
//  MarkdownNotes
//
//  Atom One Dark color scheme from VS Code
//

import SwiftUI

struct AtomOneDark {
    // Background colors
    static let background = Color(hex: "282C34")
    static let currentLine = Color(hex: "2C323C")
    static let selection = Color(hex: "3E4451")
    static let foreground = Color(hex: "ABB2BF")
    static let comment = Color(hex: "5C6370")

    // Syntax colors
    static let red = Color(hex: "E06C75")
    static let orange = Color(hex: "D19A66")
    static let yellow = Color(hex: "E5C07B")
    static let green = Color(hex: "98C379")
    static let cyan = Color(hex: "56B6C2")
    static let blue = Color(hex: "61AFEF")
    static let purple = Color(hex: "C678DD")

    // UI colors
    static let gutter = Color(hex: "4B5263")
    static let gutterBackground = Color(hex: "21252B")
    static let lineHighlight = Color(hex: "2C323C")

    // VS Code specific
    static let sidebarBackground = Color(hex: "21252B")
    static let sidebarForeground = Color(hex: "9DA5B4")
    static let tabBackground = Color(hex: "21252B")
    static let statusBarBackground = Color(hex: "21252B")
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
