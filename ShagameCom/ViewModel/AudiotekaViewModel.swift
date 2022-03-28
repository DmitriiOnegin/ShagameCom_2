//
//  AudiotekaViewModel.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 21.02.2022.
//

import Foundation
import SwiftUI
import MapKit


class AudiotekaViewModel: ObservableObject {
   
//    @Published var user = User.getUser()
//    @Published var ownBoxes = [BoxViewModel]()
//    @Published var favoriteBoxes = [BoxViewModel]()
    let allBoxes: [BoxViewModel]
    
    let locationManager = LocationManager.shared
    
    @Published var filterBoxes = [BoxViewModel]()
    
    
    @Published var region = MKCoordinateRegion()
    @Published var span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    @Published var userTrackingMode = MapUserTrackingMode.none
    
    init(allBoxes: [BoxViewModel]) {
        self.allBoxes = allBoxes
        self.updateMapRegion(location: Mark(coordinate: locationManager.lastKnownLocation?.coordinate ?? coordinateCentrMap, identifier: ""))
        
        self.filterBoxes = allBoxes
    }
    
}

// MARK: Private Methods
extension AudiotekaViewModel {
    private func updateMapRegion(location: Mark) {
        withAnimation(.easeInOut) {
            region = MKCoordinateRegion(
                center: location.coordinate,
                span: span
            )
        }
    }
}
