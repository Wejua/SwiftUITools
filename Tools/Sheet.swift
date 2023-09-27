//
//  Sheet.swift
//  VoiceChatRoom
//
//  Created by weijie.zhou on 2023/4/18.
//

import SwiftUI

public struct Sheet<T: View>: View {
    public var edge: Edge
    @Binding public var isShowing: Bool
    public var content: () -> T
    public var alignment: Alignment {
        switch edge {
        case .top:
            return .top
        case .leading:
            return .leading
        case .bottom:
            return .bottom
        case .trailing:
            return .trailing
        }
    }
    
    public init(edge: Edge, isShowing: Binding<Bool>, content: @escaping () -> T) {
        self.edge = edge
        self._isShowing = isShowing
        self.content = content
    }
    
    public var body: some View {
        ZStack(alignment: alignment) {
            if isShowing {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing.toggle()
                    }
                content().ignoresSafeArea()
                    .transition(.move(edge: edge))
            }
        }
        .animation(.easeInOut(duration: 0.2), value: isShowing)
    }
}

