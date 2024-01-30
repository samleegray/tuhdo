//
//  LocationManager.swift
//  TuhDo
//
//  Created by Samuel Gray on 1/30/24.
//

import CoreLocation

/// Location Manager. Helps handle request for access, and getting the user's location when we need it.
/// In the future it will also help notifications/geofencing.
class LocationManager: NSObject {
    static let shared = LocationManager()
    
    private let clManager = CLLocationManager()
    var enabled = false
    
    var currentLocation: CLLocation? {
        clManager.location
    }
    
    private override init() {
        super.init()
        clManager.delegate = self
    }
    
    public func requestPermission() {
        clManager.requestAlwaysAuthorization()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            enabled = true
        case .notDetermined, .restricted, .denied:
            enabled = false
        default:
            enabled = false
        }
    }
}
