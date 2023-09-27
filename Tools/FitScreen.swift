//
//  FitScreen.swift
//  HotWidget
//
//  Created by weijie.zhou on 2023/3/12.
//

import SwiftUI

public struct FitScreen<Content: View>: View {

    var referencedWidth: CGFloat

    var content: (_ factor: CGFloat) -> Content

    @ViewBuilder public var body: some View {
        GeometryReader { geo in
            content(geo.size.width/referencedWidth)
        }
    }

    public init(referencedWidth: CGFloat, @ViewBuilder content: @escaping (CGFloat) -> Content) {
        self.referencedWidth = referencedWidth
        self.content = content
    }

}

public struct FitScreenMin<Content: View>: View {
    
    var reference: CGFloat
    
    var content: (_ factor: CGFloat, _ geo: GeometryProxy) -> Content
    
    @ViewBuilder public var body: some View {
        GeometryReader { geo in
            let min = min(geo.size.width, geo.size.height)
            content(min/reference, geo)
        }
    }
    
    public init(reference: CGFloat, @ViewBuilder content: @escaping (CGFloat, GeometryProxy) -> Content) {
        self.reference = reference
        self.content = content
    }

}
