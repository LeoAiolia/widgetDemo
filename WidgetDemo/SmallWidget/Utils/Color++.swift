//
//  Color++.swift
//  SmallWidgetExtension
//
//  Created by run on 2025/2/8.
//

import UIKit
import SwiftUI

extension UIColor {
    
    convenience init(_ R: CGFloat, _ G: CGFloat, _ B: CGFloat, _ A: CGFloat = 1) {
        self.init(red: R / 255.0, green: G / 255.0, blue: B / 255.0, alpha: A)
    }
    
    convenience init(_ hexString: String) {
        
        let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        
        if hexString.hasPrefix("#") {
            // scanner.scanLocation = 1
            scanner.currentIndex = hexString.index(after: hexString.startIndex)
        }
        
        var color: UInt64 = 0
        if scanner.scanHexInt64(&color) {
            self.init(hex: UInt32(color))
        } else {
            // 处理扫描失败的情况，例如返回一个默认颜色或抛出错误
            self.init(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    convenience init(hex: UInt32) {
        let mask = 0x000000FF
        
        let r = Int(hex >> 16) & mask
        let g = Int(hex >> 8) & mask
        let b = Int(hex) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
    // UIColor -> Hex String
    var hexString: String? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        let multiplier = CGFloat(255.999999)
        
        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }
        
        if alpha == 1.0 {
            return String(
                format: "#FF%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier)
            )
        }
        else {
            return String(
                format: "#%02lX%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier),
                Int(alpha * multiplier)
            )
        }
    }
    
    var lighter: UIColor {
        
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        if getHue(&h, saturation: &s, brightness: &b, alpha: &a) {
            return UIColor(hue: h, saturation: s, brightness: min(b * 1.3, 1.0), alpha: a)
        }
        
        return self
    }
    
    var darker: UIColor {
        
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        if getHue(&h, saturation: &s, brightness: &b, alpha: &a) {
            return UIColor(hue: h, saturation: s, brightness: b * 0.75, alpha: a)
        }
        
        return self
    }
    
    static var random: UIColor {
        return UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1)
    }
    
    // 主色
    static var primary: UIColor { return UIColor(hex: 0x28D776) }
    
    // text
    static var dark: UIColor {
        return UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .dark {
                return .white
            } else {
                return .grey9
            }
        }
    }
    
    // 卡片背景
    static var card: UIColor {
        return UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .dark {
                return UIColor(hex: 0x3B3B3B)
            } else {
                return UIColor.white
            }
        }
    }
    
    // placeholder
    static var hintText: UIColor {
        return .grey7
    }
    
    // 按钮不可点击
    static var disable: UIColor {
        return UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .dark {
                return UIColor(hex: 0x3C3C3C)
            } else {
                return UIColor(hex: 0xD1D3D5)
            }
        }
    }
    
    // 次级标题
    static var textLight: UIColor {
        return UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .dark {
                return UIColor(hex: 0xDADADA)
            } else {
                return UIColor(hex: 0x5D5D5D)
            }
        }
    }
    
    static var line: UIColor {
        return UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .dark {
                return UIColor(hex: 0x6A6A6A)
            } else {
                return UIColor(hex: 0xE5E4E6)
            }
        }
    }
    
    // 背景颜色
    static var background: UIColor {
        return UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .dark {
                return .grey9
            } else {
                return .white
            }
        }
    }
    
    static var systemWhite: UIColor {
        return UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .dark {
                return .black
            } else {
                return .white
            }
        }
    }
    
    static var systemBlack: UIColor {
        return UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .dark {
                return .white
            } else {
                return .black
            }
        }
    }
    
    static func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
        return UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .dark {
                return dark
            } else {
                return light
            }
        }
    }
    
    static var grey1: UIColor {
        return UIColor(hex: 0xFFFFFF)
    }
    
    static var grey2: UIColor {
        return UIColor(hex: 0xFAFAFA)
    }
    
    static var grey3: UIColor {
        return UIColor(hex: 0xF5F5F5)
    }
    
    static var grey4: UIColor {
        return UIColor(hex: 0xF2F2F2)
    }
    
    static var grey5: UIColor {
        return UIColor(hex: 0xE0E0E0)
    }
    
    static var grey6: UIColor {
        return UIColor(hex: 0xC4C4C4)
    }
    
    static var grey7: UIColor {
        return UIColor(hex: 0x9E9E9E)
    }
    
    static var grey8: UIColor {
        return UIColor(hex: 0x757575)
    }
    
    static var grey9: UIColor {
        return UIColor(hex: 0x212121)
    }
    
    static var grey10: UIColor {
        return UIColor(hex: 0x000000)
    }
}

extension Color {
    
    init(hex: UInt32) {
        self.init(uiColor: UIColor(hex: hex))
    }
    
    static func dynamicColor(light: UIColor, dark: UIColor) -> Color {
        return Color(uiColor: UIColor.dynamicColor(light: light, dark: dark))
    }
    
    static var primary: Color {
        return Color(uiColor: .primary)
    }
    
    static var dark: Color {
        return Color(uiColor: .dark)
    }
    
    static var card: Color {
        return Color(uiColor: .card)
    }
    
    static var hintText: Color {
        return Color(uiColor: .hintText)
    }
    
    static var disable: Color {
        return Color(uiColor: .disable)
    }
    
    static var textLight: Color {
        return Color(uiColor: .textLight)
    }
    
    static var line: Color {
        return Color(uiColor: .line)
    }
    
    static var background: Color {
        return Color(uiColor: .background)
    }
    
    static var systemWhite: Color {
        return Color(uiColor: .systemWhite)
    }
    
    static var systemBlack: Color {
        return Color(uiColor: .systemBlack)
    }
    
    static var grey2: Color {
        return Color(uiColor: .grey2)
    }
    
    static var grey3: Color {
        return Color(uiColor: .grey3)
    }
    
    static var grey4: Color {
        return Color(uiColor: .grey4)
    }
    
    static var grey5: Color {
        return Color(uiColor: .grey5)
    }
    
    static var grey6: Color {
        return Color(uiColor: .grey6)
    }
    
    static var grey7: Color {
        return Color(uiColor: .grey7)
    }
    
    static var grey8: Color {
        return Color(uiColor: .grey8)
    }
    
    static var grey9: Color {
        return Color(uiColor: .grey9)
    }
}


extension Color {
    static let paleYellow   = Color(red: 252/255, green: 225/255, blue: 121/255)
    static let palePink     = Color(red: 254/255, green: 138/255, blue: 138/255)
    static let darkGreen    = Color(red: 0/255, green: 67/255, blue: 13/255)
    static let paleGreen    = Color(red: 163/255, green: 230/255, blue: 127/255)
    static let paleBlue     = Color(red: 139/255, green: 229/255, blue: 233/255)
    static let skyBlue      = Color(red: 103/255, green: 155/255, blue: 197/255)
    static let paleOrange   = Color(red: 197/255, green: 161/255, blue: 103/255)
    static let darkOrange   = Color(red: 172/255, green: 110/255, blue: 16/255)
    static let paleRed      = Color(red: 174/255, green: 80/255, blue: 80/255)
    static let paleBrown    = Color(red: 124/255, green: 102/255, blue: 85/255)
}
