//
//  VideoPlayer.swift
//  VoiceChatRoom
//
//  Created by weijie.zhou on 2023/4/16.
//

import AVKit
import SwiftUI

public struct VideoPlayer: UIViewControllerRepresentable {
    public var videoURL: URL?

    private var player: AVPlayer {
        return AVPlayer(url: videoURL!)
    }
    
    public init(videoURL: URL? = nil) {
        self.videoURL = videoURL
    }

    public func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.modalPresentationStyle = .fullScreen
        controller.player = player
        controller.player?.play()
        
        return controller
    }

    public func updateUIViewController(_ playerController: AVPlayerViewController, context: Context) {}
}
