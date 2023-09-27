//
//  ViewExtensions.swift
//  HotWidget
//
//  Created by 周位杰 on 2022/12/31.
//

import Foundation
import SwiftUI

struct CustomBackViewModifier<T>: ViewModifier where T: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var label: () -> T
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        label()
                    }
                }
            }
    }
}

extension View {
    public func foregroundLinearGradient(colors: [Color], startPoint: UnitPoint, endPoint: UnitPoint) -> some View {
        self.overlay {
            LinearGradient(
                colors: colors,
                startPoint: startPoint,
                endPoint: endPoint
            )
            .mask(
                self
            )
        }
    }
    
    @ViewBuilder  public func customBackView(@ViewBuilder label: @escaping () -> some View) -> some View {
        self.modifier(CustomBackViewModifier(label: label))
    }
    
    public func navigationLink(@ViewBuilder destination: @escaping () -> some View) -> some View {
        return NavigationLink(destination: destination) {
            self
        }
    }
}

extension View {
    public func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners, cornerRadii: CGSize(width:
                                                                                    radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    
    public func topSafeAreaColor(color: Color?) -> some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                self
                
                color
                    .frame(height: geo.safeAreaInsets.top)
                    .ignoresSafeArea()
            }
        }
    }
    
    public func bottomSafeAreaColor(color: Color?) -> some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {
                self
                
                color
                    .frame(height: geo.safeAreaInsets.bottom)
                    .offset(y: geo.safeAreaInsets.bottom)
                    .ignoresSafeArea()
            }
        }
    }
}

public extension View {
    @ViewBuilder func ifdo<Content: View>(_ condition: @autoclosure () -> Bool, transform: @escaping (Self) -> Content) -> some View {
        if condition() {
            transform(self)
        } else {
            self
        }
    }
    
    @ViewBuilder func ifdo2(_ condition: Bool, transform: @escaping (Self) -> some View) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
