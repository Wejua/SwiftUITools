//
//  Tools.swift
//  HotWidget
//
//  Created by 周位杰 on 2022/12/31.
//

import Foundation
import SwiftUI

extension Color {
    public init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        let length = hexSanitized.count
        
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
        
        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
            
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
            
        } else {
            return nil
        }
        
        self.init(red: r, green: g, blue: b, opacity: a)
    }
    
    public func toHex() -> String? {
        let uic = UIColor(self)
        guard let components = uic.cgColor.components, components.count >= 3 else {
            return nil
        }
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)
        
        if components.count >= 4 {
            a = Float(components[3])
        }
        
        if a != Float(1.0) {
            return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        } else {
            return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }
    
}

public extension Text {
    func textSett(color: Color, FName: CommonFontNames, Fsize: CGFloat, lineLi: Int?, maxW: CGFloat? = nil) -> some View {
        self
            .foregroundColor(color)
            .font(name: FName, size: Fsize)
            .ifdo(lineLi != nil, transform: { text in
                text.lineLimit(lineLi!)
            })
            .ifdo(maxW != nil) { text in
                text.frame(maxWidth: maxW!, alignment: .leading)
            }
    }
}

public extension TextField {
    func TextFieldSett(textC: Color, cursorC: Color, fontN: CommonFontNames, fontS: CGFloat) -> some View {
        self
            .foregroundColor(textC)
            .tint(cursorC)
            .font(name: fontN, size: fontS)
    }
}

public extension Data {
    func descriptionObject() -> AnyObject {
        let object = String(data: self, encoding: .utf8)! as AnyObject
        return object
    }
}

public extension Array {
    func valueIn(index: Int) -> Element? {
        if index < self.count && index >= 0 && self.count > 0 {
            return self[index]
        }
        return nil
    }
}

public extension View {
    @ViewBuilder func inlineNavigationTitle(title: Text) -> some View {
        self
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
    }
    
    func customSheet(edge: Edge, isShowing: Binding<Bool>, content: @escaping () -> some View) -> some View {
        ZStack {
            self
            Sheet(edge: edge, isShowing: isShowing, content: content)
        }
    }
}

public extension Int64 {
    func format() -> String {
        let curDate = Date()
        let date = Date(timeIntervalSince1970: Double(self)/1000.0)
        let interval = curDate.timeIntervalSince(date)
        if interval < 60.0*100 {
            return "\(Int(interval/100))秒前"
        } else if interval < 60*60*100 {
            return "\(Int(interval/60/100))分钟前"
        } else if interval < 24*60*60*100 {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            return formatter.string(from: date)
        } else if interval < 31*24*60*60*100 {
            return "\(Int(interval/100/60/60/24))天前"
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy:MM:dd:HH:mm"
            return formatter.string(from: date)
        }
    }
}



