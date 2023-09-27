//
//  WeiBoReSouWebView.swift
//  HotWidget
//
//  Created by weijie.zhou on 2023/3/20.
//

import SwiftUI
import WebKit

public struct WeiBoReSouWebView: UIViewRepresentable {
    public var urlString: String
    
    public init(urlString: String) {
        self.urlString = urlString
    }
    
    public func makeUIView(context: Context) -> WKWebView {
        let webV = WKWebView()
        webV.allowsBackForwardNavigationGestures = true
//        if let url = URL(string: weiBoReSouHomeURL) {
//            webV.load(URLRequest(url: url))
//        }
        return webV
    }
    
    public func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
    
    public typealias UIViewType = WKWebView
    
}
