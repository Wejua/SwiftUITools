//
//  LoginTools.swift
//  VoiceChatRoom
//
//  Created by weijie.zhou on 2023/4/24.
//

import UIKit


public var appVersion: String { Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""}
public var buildNumber: String {Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? ""}
public var identifierForVender: String {UIDevice.current.identifierForVendor?.uuidString ?? ""}
public var systemVersion:String {UIDevice.current.systemVersion}
public var deviceName: String {UIDevice.current.name}
public var systemName: String {UIDevice.current.systemName}
