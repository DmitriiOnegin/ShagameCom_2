//
//  LocationManager.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 21.02.2022.
//

import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    
    private let manager: CLLocationManager
    var lastKnownLocation: CLLocation?
    
    init(manager: CLLocationManager = CLLocationManager()) {

        self.manager = manager
        super.init()
        self.startUpdating()
       
        print("CLLocationManager init")
    }
    
    private func startUpdating() {
        self.manager.delegate = self
        self.manager.requestWhenInUseAuthorization()
        self.manager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied{
            print("denied")
        }
        else{
            print("athorized")
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        lastKnownLocation = locations.last
        print("lastKnownLocation: \(lastKnownLocation)")
    }
 

}
