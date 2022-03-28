//
//  Mark.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 03.02.2022.
//

import Foundation

import CoreLocation
//import MapKit

struct Mark: Identifiable, Codable {
    
    var id = UUID()
    var number: Int = 1
    var name: String = ""
    var coordinate: CLLocationCoordinate2D
    var show = false
    var identifier: String
    var dis: Double = 0
    var rec: Double = 0
    var timeStart: Double = 0
    var numberEpizod: Int = 0
    
    static func getMark() -> Mark {
        Mark(coordinate: coordinateCentrMap, identifier: "")
    }
}

extension CLLocationCoordinate2D: Codable {
     public func encode(to encoder: Encoder) throws {
         var container = encoder.unkeyedContainer()
         try container.encode(longitude)
         try container.encode(latitude)
     }
      
     public init(from decoder: Decoder) throws {
         var container = try decoder.unkeyedContainer()
         let longitude = try container.decode(CLLocationDegrees.self)
         let latitude = try container.decode(CLLocationDegrees.self)
         self.init(latitude: latitude, longitude: longitude)
     }
 }
