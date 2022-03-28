//
//  Box.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 03.02.2022.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import CoreLocation

struct Box: Identifiable, Decodable {
   // var id = UUID()
    @DocumentID var id: String?
    let title: String
    let description: String
    let timestamp: Timestamp
    let imageUrl: String
    let audioUrl: String
    let ownerUid: String
    var ownerFullName: String
    let oldCondition: Bool
   
    let conditionLocation: [GeoPoint]
  //  let conditionLocation: [CLLocationCoordinate2D]
    
    var totalRating: [Double]
    var totalViews: Int
    var totalSteps: Int
    var totalTime: Int
    
    var didFavorite: Bool? = false
    var didOpen: Bool? = false
    var canSave: Bool? = false
    
    var conditionLocationCL: [CLLocationCoordinate2D]? {
        conditionLocation.map {
            CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)
        }
    }
    
    static func getBox() -> Box {
      Box(title: "",
          description: "",
          timestamp: Timestamp(),
          imageUrl: "",
          audioUrl: "",
          ownerUid: "",
          ownerFullName: "",
          oldCondition: false,
          conditionLocation: [GeoPoint(latitude: 0, longitude: 0)],
          totalRating: [0, 0],
          totalViews: 0,
          totalSteps: 0,
          totalTime: 0)
    }
    
}
