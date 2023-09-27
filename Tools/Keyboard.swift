//
//  Keyboard.swift
//  VoiceChatRoom
//
//  Created by weijie.zhou on 2023/5/8.
//

import Combine
import UIKit


/// Publisher to read keyboard changes.
public protocol KeyboardReadable {
    var keyboardPublisher: AnyPublisher<Bool, Never> { get }
}

public extension KeyboardReadable {
    var keyboardPublisher: AnyPublisher<Bool, Never> {
        Publishers.Merge(
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillShowNotification)
                .map { _ in true },
            
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillHideNotification)
                .map { _ in false }
        )
        .eraseToAnyPublisher()
    }
}

/*
 struct ContentView: View, KeyboardReadable {
     
     @State private var text: String = ""
     @State private var isKeyboardVisible = false
     
     var body: some View {
         TextField("Text", text: $text)
             .onReceive(keyboardPublisher) { newIsKeyboardVisible in
                 print("Is keyboard visible? ", newIsKeyboardVisible)
                 isKeyboardVisible = newIsKeyboardVisible
             }
     }
 }
 */
