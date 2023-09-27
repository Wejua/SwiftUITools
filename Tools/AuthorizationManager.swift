//
//  Settings.swift
//  SwiftUITools
//
//  Created by weijie.zhou on 2023/5/30.
//

import Foundation
import CoreTelephony
import Photos
import AVFoundation
import CoreLocation
import UserNotifications
import Contacts
import CoreBluetooth
import HealthKit

public class AuthorizationManager: NSObject {
    public enum AuthorizationStatus {
        case authorized
        case unauthorized
    }
    public enum AuthorizationType {
        case photos
        case camera
        case location
        case contacts
        case notification
        case bluetooth
        case health
        case network
        case microphone
    }
    
    public func isAuthorized(type: AuthorizationType) async -> Bool {
        switch type {
        case .photos:
            return photoState()
        case .camera:
            return cameraState()
        case .location:
            return locationState()
        case .contacts:
            return contactsState()
        case .notification:
            return await notiState()
        case .bluetooth:
            return bluetoothState()
        case .health:
            return HKHealthStore.isHealthDataAvailable()
        case .network:
            return cellularState()
        case .microphone:
            return microphoneState()
        }
    }
    
    public func requestAuthorization(type: AuthorizationType) async -> Bool? {
        switch type {
        case .photos:
            return await requestPhotoAuthorization()
        case .camera:
            return await requestCameraAuthorization()
        case .location:
            requestLocationAuthorization()
        case .contacts:
            return await requestContactsAuthorization()
        case .notification:
            return await requestNotiAuthorization()
        case .bluetooth:
            return nil
        case .health:
            return nil
        case .network:
            return nil
        case .microphone:
            return await requestMicrophoneAuthorization()
        }
        return nil
    }
    
    public static func url(type: AuthorizationManager.AuthorizationType) -> URL {
        switch type {
        case .photos:
            return URL(string: "App-Prefs:root=Photos")!
        case .camera:
            return URL(string: "App-Prefs:root=Privacy&path=CAMERA")!
        case .location:
            return URL(string: "App-Prefs:root=Privacy&path=LOCATION")!
        case .contacts:
            return URL(string: "App-Prefs:root=Privacy&path=CONTACTS")!
        case .notification:
            return URL(string: "App-Prefs:root=NOTIFICATIONS_ID")!
        case .bluetooth:
            return URL(string: "App-Prefs:root=Bluetooth")!
        case .health:
            return URL(string: "App-Prefs:root=Privacy&path=HEALTH")!
        case .network:
            return URL(string: "App-Prefs:root=MOBILE_DATA_SETTINGS_ID")!
        case .microphone:
            return URL(string: "App-Prefs:root=Privacy&path=MICROPHONE")!
        }
    }
    
    private func bluetoothState() -> Bool {
        let status = CBCentralManager.authorization
        switch status {
        case .allowedAlways: return true
        default: return true
        }
    }
    
    private func contactsState() -> Bool {
        let status = CNContactStore.authorizationStatus(for: .contacts)
        switch status {
        case .authorized: return true
        default: return false
        }
    }
    
    private func requestContactsAuthorization() async -> Bool {
        await withCheckedContinuation { continuation in
            CNContactStore().requestAccess(for: .contacts) { granted, error in
                if granted {
                    continuation.resume(returning: true)
                } else {
                    continuation.resume(returning: false)
                }
            }
        }
    }
    
    private func notiState() async -> Bool {
        await withCheckedContinuation { continuation in
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                switch settings.authorizationStatus {
                case .authorized:
                    continuation.resume(returning: true)
                default:
                    continuation.resume(returning: false)
                }
            }
        }
    }
    
    private func requestNotiAuthorization() async -> Bool {
        await withCheckedContinuation { continuation in
            UNUserNotificationCenter.current().requestAuthorization { granted, error in
                if granted {
                    continuation.resume(returning: true)
                } else {
                    continuation.resume(returning: false)
                }
            }
        }
    }
    
    private func locationState() -> Bool {
        let location = CLLocationManager()
        location.delegate = self
        let status = location.authorizationStatus
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            return true
        } else {
            return false
        }
    }
    
    private func requestLocationAuthorization() {
        let location = CLLocationManager()
        location.delegate = self
        location.requestWhenInUseAuthorization()
    }
    
    /// 联网权限
    private func cellularState() -> Bool {
        let state = CTCellularData().restrictedState
        switch state {
        case .notRestricted:
            return true
        case .restricted, .restrictedStateUnknown:
            return false
        @unknown default:
            fatalError()
        }
    }
    
    private func requestPhotoAuthorization() async -> Bool {
        await withCheckedContinuation { continuation in
            PHPhotoLibrary.requestAuthorization { status in
                if status == .authorized  || status == .limited {
                    continuation.resume(returning: true)
                } else {
                    continuation.resume(returning: false)
                }
            }
        }
    }
    
    private func photoState() -> Bool {
        let status = PHPhotoLibrary.authorizationStatus()
        if status == .authorized || status == .limited {
            return true
        } else {
            return false
        }
    }
    
    private func cameraState() -> Bool {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        if status == .authorized {
            return true
        } else {
            return false
        }
    }
    
    private func requestCameraAuthorization() async -> Bool {
        await withCheckedContinuation { continuation in
            AVCaptureDevice.requestAccess(for: .video) { granted in
                continuation.resume(returning: granted ? true : false)
            }
        }
    }
    
    private func microphoneState() -> Bool {
        let status = AVCaptureDevice.authorizationStatus(for: .audio)
        if status == .authorized {
            return true
        } else {
            return false
        }
    }
    
    private func requestMicrophoneAuthorization() async -> Bool {
        return await withCheckedContinuation { continuation in
            AVCaptureDevice.requestAccess(for: .audio) { granted in
                continuation.resume(returning: granted ? true : false)
            }
        }
    }
}

extension AuthorizationManager: CLLocationManagerDelegate {
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            return
        case .notDetermined:
            return
        case .restricted:
            return
        case .denied:
            return
        case .authorizedAlways:
            return
        @unknown default:
            return
        }
    }
}
