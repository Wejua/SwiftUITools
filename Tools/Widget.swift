//
//  Widget.swift
//  HotWidget
//
//  Created by weijie.zhou on 2023/5/3.
//

import SwiftUI
import WidgetKit

/*
 https://developer.apple.com/design/human-interface-guidelines/widgets
 */

public enum IosScreenSize {
    case _430_932
    case _428_926
    case _414_896
    case _414_736
    case _393_852
    case _390_844
    case _375_812
    case _375_667
    case _360_780
    case _320_568
}

public func iosWidgetSize(screenSize: CGSize, family: WidgetFamily) -> CGSize {
    if screenSize == CGSize(width: 430, height: 932) ||
        screenSize ==  CGSize(width: 428, height: 926)
    {
        switch family {
        case .systemSmall:
            return CGSize(width: 170, height: 170)
        case .systemMedium:
            return CGSize(width: 364, height: 170)
        case .systemLarge:
            return CGSize(width: 364, height: 382)
        case .accessoryCircular:
            return CGSize(width: 76, height: 76)
        case .accessoryRectangular:
            return CGSize(width: 172, height: 76)
        case .accessoryInline:
            return CGSize(width: 257, height: 26)
        default:
            return .zero
        }
    } else if screenSize == CGSize(width: 414, height: 896) {
        switch family {
        case .systemSmall:
            return CGSize(width: 169, height: 169)
        case .systemMedium:
            return CGSize(width: 360, height: 169)
        case .systemLarge:
            return CGSize(width: 360, height: 379)
        case .accessoryCircular:
            return CGSize(width: 76, height: 76)
        case .accessoryRectangular:
            return CGSize(width: 160, height: 72)
        case .accessoryInline:
            return CGSize(width: 248, height: 26)
        default:
            return .zero
        }
    } else if screenSize == CGSize(width: 414, height: 736) {
        switch family {
        case .systemSmall:
            return CGSize(width: 159, height: 159)
        case .systemMedium:
            return CGSize(width: 348, height: 157)
        case .systemLarge:
            return CGSize(width: 348, height: 357)
        case .accessoryCircular:
            return CGSize(width: 76, height: 76)
        case .accessoryRectangular:
            return CGSize(width: 170, height: 76)
        case .accessoryInline:
            return CGSize(width: 248, height: 26)
        default:
            return .zero
        }
    } else if screenSize == CGSize(width: 393, height: 852) ||
                screenSize == CGSize(width: 390, height: 844)
    {
        switch family {
        case .systemSmall:
            return CGSize(width: 158, height: 158)
        case .systemMedium:
            return CGSize(width: 338, height: 158)
        case .systemLarge:
            return CGSize(width: 338, height: 354)
        case .accessoryCircular:
            return CGSize(width: 72, height: 72)
        case .accessoryRectangular:
            return CGSize(width: 160, height: 72)
        case .accessoryInline:
            return CGSize(width: 234, height: 26)
        default:
            return .zero
        }
    } else if screenSize == CGSize(width: 375, height: 812) {
        switch family {
        case .systemSmall:
            return CGSize(width: 155, height: 155)
        case .systemMedium:
            return CGSize(width: 329, height: 155)
        case .systemLarge:
            return CGSize(width: 329, height: 345)
        case .accessoryCircular:
            return CGSize(width: 72, height: 72)
        case .accessoryRectangular:
            return CGSize(width: 157, height: 72)
        case .accessoryInline:
            return CGSize(width: 225, height: 26)
        default:
            return .zero
        }
    } else if screenSize == CGSize(width: 375, height: 667) {
        switch family {
        case .systemSmall:
            return CGSize(width: 148, height: 148)
        case .systemMedium:
            return CGSize(width: 321, height: 148)
        case .systemLarge:
            return CGSize(width: 321, height: 324)
        case .accessoryCircular:
            return CGSize(width: 68, height: 68)
        case .accessoryRectangular:
            return CGSize(width: 153, height: 68)
        case .accessoryInline:
            return CGSize(width: 225, height: 26)
        default:
            return .zero
        }
    } else if screenSize == CGSize(width: 360, height: 780) {
        switch family {
        case .systemSmall:
            return CGSize(width: 155, height: 155)
        case .systemMedium:
            return CGSize(width: 329, height: 155)
        case .systemLarge:
            return CGSize(width: 329, height: 345)
        case .accessoryCircular:
            return CGSize(width: 72, height: 72)
        case .accessoryRectangular:
            return CGSize(width: 157, height: 72)
        case .accessoryInline:
            return CGSize(width: 225, height: 26)
        default:
            return .zero
        }
    } else if screenSize == CGSize(width: 320, height: 568) {
        switch family {
        case .systemSmall:
            return CGSize(width: 141, height: 141)
        case .systemMedium:
            return CGSize(width: 292, height: 141)
        case .systemLarge:
            return CGSize(width: 292, height: 311)
        case .accessoryCircular:
            return .zero
        case .accessoryRectangular:
            return .zero
        case .accessoryInline:
            return .zero
        default:
            return .zero
        }
    }
    switch family {
    case .systemSmall:
        return CGSize(width: 155, height: 155)
    case .systemMedium:
        return CGSize(width: 329, height: 155)
    case .systemLarge:
        return CGSize(width: 329, height: 345)
    case .accessoryCircular:
        return CGSize(width: 72, height: 72)
    case .accessoryRectangular:
        return CGSize(width: 157, height: 72)
    case .accessoryInline:
        return CGSize(width: 225, height: 26)
    default:
        return .zero
    }
}

