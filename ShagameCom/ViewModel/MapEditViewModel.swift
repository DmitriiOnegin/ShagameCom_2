//
//  MapEditViewModel.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 21.02.2022.
//

import SwiftUI
import CoreLocation
import MapKit

class MapEditViewModel: ObservableObject {
    
    let locationManager = LocationManager.shared
    
    @Published var locations: [Mark] = []
    @Published var marshrut: [Mark] = []
    @Published var numberItem = 0
    
    @Published var region = MKCoordinateRegion()
    @Published var span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    @Published var userTrackingMode = MapUserTrackingMode.none
    
    var scale: Double {
        var s = 1.0
        if region.span.latitudeDelta >= 0.003 {
            s = 1/(0.003 * 1000) * 1.5
        } else {
            if  region.span.latitudeDelta < 0.003 && region.span.latitudeDelta > 0.001{
                s = 1/(region.span.longitudeDelta * 1000) * 1.5
            } else {
                s = 1/(0.001 * 1000) * 1.5
            }}
        return  s
    }
    var scale2: Double {
        var s = 1.0
        if region.span.latitudeDelta > 0.0015 {
            s = 1/(region.span.longitudeDelta * 1000) * 1.5
        } else {
            s = 1/(0.0015 * 1000) * 1.5
        }
        return  s
    }
    
    init() {
        self.updateMapRegion(location: Mark(coordinate: locationManager.lastKnownLocation?.coordinate ?? coordinateCentrMap, identifier: ""))
    }
    
    func showMyLocation() {
        region.center = locationManager.lastKnownLocation?.coordinate ?? coordinateCentrMap
    }
    
    func createMarshrut(tipe: String) {
        marshrut.removeAll()
        let number = locations.count
        
        var tupCount: Int = 1
        var distanseM = 0.0
        var rec = 0.0
        
        if locations.count > 1 {
            
            for item in 2 ... number {
                var marshrutPoint: [Mark] = []
                var marshrutLine: [Mark] = []
                
                let tup1 = locations[item - 2]
                let tup2 = locations[item - 1]
                
                distanseM = distanse(
                    lat1: tup1.coordinate.latitude,
                    lat2: tup2.coordinate.latitude,
                    lon1: tup1.coordinate.longitude,
                    lon2: tup2.coordinate.longitude)
                
                if distanseM >= 20 {
                    tupCount = Int(round(distanseM/20))
                    if tupCount >= 2 {
                        
                        for i in 1..<tupCount {
                            
                            let coordinate = CLLocationCoordinate2D(latitude: tup1.coordinate.latitude + (tup2.coordinate.latitude - tup1.coordinate.latitude)/Double(tupCount) * Double(i), longitude: tup1.coordinate.longitude + (tup2.coordinate.longitude - tup1.coordinate.longitude)/Double(tupCount) * Double(i))
                            
                            let mark = Mark(number: item - 2, name: "", coordinate: coordinate, identifier: "marshrut", dis: distanseM, rec: rec)
                            
                            marshrutPoint.append(mark)
                        }
                    }
                }
                
                let coordinate = CLLocationCoordinate2D(latitude: tup1.coordinate.latitude + (tup2.coordinate.latitude - tup1.coordinate.latitude)/Double(2), longitude: tup1.coordinate.longitude + (tup2.coordinate.longitude - tup1.coordinate.longitude)/Double(2))
                
                rec = Double((atan((tup1.coordinate.latitude - tup2.coordinate.latitude) * 2 / (tup2.coordinate.longitude - tup1.coordinate.longitude))))
                
                marshrutLine.append(Mark(number: 00, name: "", coordinate: coordinate, identifier: "1", dis: distanseM * 6, rec: rec))
                
                if tipe == "point" {
                    marshrut += marshrutPoint
                } else { if tipe == "line" {
                    marshrut += marshrutLine
                }
                }
            }
        }
    }
    
    func dellPointLocations() {
        
        if !locations.isEmpty {
            let count = locations.count
            
            locations.remove(at: numberItem)
            if numberItem < count - 1 {
                for i in numberItem ..< count - 1 {
                    locations[i].number -= 1
                    
                    if locations[i].numberEpizod != 0 {
                        locations[i].numberEpizod -= 1
                    }
                }
            }
        }
    }
    
    func dellLastPointLocations() {
        
        if !locations.isEmpty {
            
            locations.removeLast()
        }
    }
    
    func locationsAppendMark(coordinate: MKCoordinateRegion) {
        
        let number = locations.count
        let name = ""
        var dis = 0.0
        
        if locations.count > 1 {
            let tup1 = locations[number - 2]
            let tup2 = locations[number - 1]
            
            dis = distanse(
                lat1: tup1.coordinate.latitude,
                lat2: tup2.coordinate.latitude,
                lon1: tup1.coordinate.longitude,
                lon2: tup2.coordinate.longitude)
        }
        
        var mark = Mark(number: number + 1, name: name, coordinate: coordinate.center, identifier: "epizod", dis: dis, rec: 0)
        
        if locations.count > 1 {
            if locations[locations.count - 1].coordinate.latitude != mark.coordinate.latitude && locations[locations.count - 1].coordinate.longitude != mark.coordinate.longitude {
                mark.numberEpizod = number + 1
                locations.append(mark)
            } else {
                mark.numberEpizod = number + 1
                locations.append(mark)
            }
        }
        else {
            mark.numberEpizod = number + 1
            locations.append(mark)
        }
    }
    
    func createTimeMarshrut() {
        
        var newlocations: [Mark] = locations
        var newMarshrut: [Mark] = []
        
        struct Epizod {
            var number = 0
            var timeStart = 0.0
            var marks: [Mark] = []
        }
        
        var pointsLocations: [Epizod] = []
        var pointsEpisods: [Epizod] = []
        
        for i in 0 ..< locations.count {
            pointsLocations.append(Epizod(number: i, timeStart: 0, marks: []))
            for y in 0 ..< marshrut.count {
                if marshrut[y].number == i {
                    pointsLocations[i].marks.append(marshrut[y])
                }
            }
        }
        
        for i in 0 ..< locations.count {
            
            if locations[i].numberEpizod > 0 {
                pointsEpisods.append(Epizod(number: i, timeStart: locations[i].timeStart, marks: []))
                pointsEpisods[pointsEpisods.count - 1].marks = pointsLocations[i].marks
            } else {
                pointsEpisods[pointsEpisods.count - 1].marks.append(locations[i])
                pointsEpisods[pointsEpisods.count - 1].marks += pointsLocations[i].marks
            }
        }
        
        for i in 0 ..< pointsEpisods.count {
            var duration = 0.0
            if i + 1 < pointsEpisods.count {
                duration = pointsEpisods[i + 1].timeStart - pointsEpisods[i].timeStart
            }
            let timeShag = duration / Double(pointsEpisods[i].marks.count + 1)
            for y in 0 ..< pointsEpisods[i].marks.count {
                pointsEpisods[i].marks[y].timeStart = pointsEpisods[i].timeStart + Double((y + 1)) * timeShag
                if pointsEpisods[i].marks[y].identifier == "marshrut" {
                    newMarshrut.append(pointsEpisods[i].marks[y])
                } else {
                    for z in 0 ..< locations.count {
                        if locations[z].id == pointsEpisods[i].marks[y].id {
                            newlocations[z].timeStart = pointsEpisods[i].marks[y].timeStart
                        }
                    }
                }
            }
        }
        locations = newlocations
        marshrut = newMarshrut
    }
    
    
}

// MARK: Private Methods
extension MapEditViewModel {
    private func updateMapRegion(location: Mark) {
        withAnimation(.easeInOut) {
            region = MKCoordinateRegion(
                center: location.coordinate,
                span: span
            )
        }
    }
    
    private func distanse(lat1: Double, lat2: Double, lon1: Double, lon2: Double) -> Double {
        
        let R = 6378.137 // Radius of earth in KM
        let dLat = lat2 * .pi / 180 - lat1 * .pi / 180
        let dLon = lon2 * .pi / 180 - lon1 * .pi / 180
        let a = sin(dLat/2) * sin(dLat/2) + cos(lat1 * .pi / 180) * cos(lat2 * .pi / 180) * sin(dLon/2) * sin(dLon/2)
        let c = 2 * atan2(sqrt(a), sqrt(1-a))
        let d = R * c
        
        return d * 1000
    }
}

