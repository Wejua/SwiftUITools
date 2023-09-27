//
//  LocationManager.swift
//  HotWidget
//
//  Created by weijie.zhou on 2023/3/29.
//

import CoreLocation


public class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    public var locationManager: CLLocationManager = CLLocationManager()
    @Published public var authorizationStatus: CLAuthorizationStatus?
    
    public override init() {
        super.init()
        self.locationManager.delegate = self
    }
    
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        if manager.authorizationStatus == .authorizedAlways || manager.authorizationStatus == .authorizedWhenInUse {
//            locationManager.requestLocation()
//        }
        authorizationStatus = manager.authorizationStatus
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.requestLocation()
            break
        case .restricted, .denied:
            break
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            break
        @unknown default:
            fatalError()
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error.localizedDescription)")
    }
}


