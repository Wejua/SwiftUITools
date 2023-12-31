//
//  AudioPlayer.swift
//  Voice Recorder
//
//  Created by Pinlun on 2019/10/30.
//  Copyright © 2019 Pinlun. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import AVFoundation

public class AudioPlayer: NSObject, ObservableObject, AVAudioPlayerDelegate {
    
    public let objectWillChange = PassthroughSubject<AudioPlayer, Never>()
    
    public var isPlaying = false {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    public var audioPlayer: AVAudioPlayer!
    
    public func setup(audioUrl: URL) {
        let playbackSession = AVAudioSession.sharedInstance()
        
        do {
            try playbackSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        } catch {
            print("Playing over the device's speakers failed")
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioUrl)
            audioPlayer.delegate = self
//            audioPlayer.play()
//            isPlaying = true
        } catch {
            print("Playback failed.")
        }
    }
    
    public func playback() {
        audioPlayer.play()
        isPlaying = true
    }
    
    public func startPlayback(audio: URL) {
        let playbackSession = AVAudioSession.sharedInstance()

        do {
            try playbackSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        } catch {
            print("Playing over the device's speakers failed")
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audio)
            audioPlayer.delegate = self
            audioPlayer.play()
            isPlaying = true
        } catch {
            print("Playback failed.")
        }
    }
    
    public func stopPlayback() {
        audioPlayer.stop()
        isPlaying = false
    }
    
    public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            isPlaying = false
        }
    }
}
