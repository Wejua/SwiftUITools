//
//  CustomTrasition.swift
//  VoiceChatRoom
//
//  Created by weijie.zhou on 2023/5/11.
//

import Foundation
import SwiftUI
import UIKit

public extension UIWindow {
    
    static var topMostController: UIViewController? {
        let keyWindow = UIApplication.shared.windows
            .filter { $0.isKeyWindow }
            .first
        
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            return topController
        }
        
        return nil
    }
}

public extension View {
    
    func presentContentOverFullScreen<ContentView>(
        isPresented: Binding<Bool>,
        content: (Binding<Bool>) -> ContentView
    ) -> some View where ContentView: View {
        let presentingController = UIWindow.topMostController as? PresentedHostingController<ContentView>
        if isPresented.wrappedValue {
            let isViewControllerAlreadyPresented = presentingController != nil
            if isViewControllerAlreadyPresented {
                // this prevent from presenting one more instance of controller
                // when SwiftUI View redraw body during presentation of this controller
                return self
            }

            let presentableContent = PresentedHostingController<ContentView>(
                rootView: content(isPresented)
            )
            presentableContent.modalPresentationStyle = .overCurrentContext
            presentableContent.modalTransitionStyle = .crossDissolve
            presentableContent.view.backgroundColor = .clear
            
            UIWindow.topMostController?.present(presentableContent, animated: true)
        } else {
            if let controller = presentingController {
                controller.dismiss(animated: true)
            }
        }
        
        return self
    }
}

fileprivate final class PresentedHostingController<Content>:
    UIHostingController<Content> where Content: View
{
    /*dummy*/
}


