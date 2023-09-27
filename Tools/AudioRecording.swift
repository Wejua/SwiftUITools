//
//  AudioRecording.swift
//  VoiceChatRoom
//
//  Created by weijie.zhou on 2023/4/21.
//

import Foundation
import AVFoundation

public class AudioRecording: ObservableObject {
    
    var fileName: String = "recording"
    let player = AudioPlayer()
    var fileUrl: URL {
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let audioFilename = documentPath.appendingPathComponent(fileName+".m4a")
        return audioFilename
    }
    var audioRecorder: AVAudioRecorder? {
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        return try? AVAudioRecorder(url: fileUrl, settings: settings)
    }
    
    init(fileName: String) {
        self.fileName = fileName
    }
    
    public func record() {
        let recordingSession = AVAudioSession.sharedInstance()
            
        do {
            try recordingSession.setCategory(.playAndRecord)
            try recordingSession.setActive(true)
                
            recordingSession.requestRecordPermission({ result in
                    guard result else { return }
            })
                
        } catch {
            print("ERROR: Failed to set up recording session.")
        }
        
        audioRecorder?.record()
        audioRecorder?.isMeteringEnabled = true
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [self] _ in
            audioRecorder?.updateMeters()
            let _ = audioRecorder?.averagePower(forChannel: 0)
            //                print(db)
        }
    }
    
    public func stopRecord() -> URL {
        audioRecorder?.stop()
        return self.fileUrl
    }
    
    public func play() {
        player.startPlayback(audio: fileUrl)
    }
    
}
