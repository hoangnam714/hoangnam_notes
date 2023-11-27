//
//  Color+Extension.swift
//  Notes
//
//  Created by admin on 24/11/2023.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: String, alpha: Double = 1.0) {
        if hex.count == 0 {
            self.init(.clear)
            return
        }
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = Double((rgbValue & 0xff0000) >> 16) / 0xff
        let g = Double((rgbValue & 0xff00) >> 8) / 0xff
        let b = Double(rgbValue & 0xff) / 0xff
        
        self.init(.sRGB, red: r, green: g, blue: b, opacity: alpha)
    }
}
