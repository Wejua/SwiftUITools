//
//  Font.swift
//  VoiceChatRoom
//
//  Created by weijie.zhou on 2023/4/13.
//

import SwiftUI

public enum CommonFontNames: String {
    case PingFangSCRegular = "PingFangSC-Regular"
    case PingFangSCUltralight = "PingFangSC-Ultralight"
    case PingFangSCThin = "PingFangSC-Thin"
    case PingFangSCLight = "PingFangSC-Light"
    case PingFangSCMedium = "PingFangSC-Medium"
    case PingFangSCSemibold = "PingFangSC-Semibold"
    case Helvetica = "Helvetica"
    case HelveticaOblique = "Helvetica-Oblique"
    case HelveticaLight = "Helvetica-Light"
    case HelveticaLightOblique = "Helvetica-LightOblique"
    case HelveticaBold = "Helvetica-Bold"
    case HelveticaBoldOblique = "Helvetica-BoldOblique"
    case PingFangHKRegular = "PingFangHK-Regular"
    case PingFangHKUltralight = "PingFangHK-Ultralight"
    case PingFangHKThin = "PingFangHK-Thin"
    case PingFangHKLight = "PingFangHK-Light"
    case PingFangHKMedium = "PingFangHK-Medium"
    case PingFangHKSemibold = "PingFangHK-Semibold"
}

public extension View {

    @ViewBuilder func font(name: CommonFontNames, size: CGFloat) -> some View {
        let font = Font(UIFont(name: name.rawValue, size: size)!)
        self.font(font)
    }
}


