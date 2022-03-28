//
//  NewBox.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 03.02.2022.
//

import Foundation
import CoreLocation

struct NewBox: Identifiable, Codable{
    
    var id = UUID()
    var title: String
    var description: String
    var imageData: Data
    var audioData: Data
    var oldCondition: Bool
    var conditionLocation: [Mark]
    var totalSteps: Int
    var totalTime: Int
    
    static func getNewBox() -> NewBox {
        NewBox(title: "", description: "", imageData: Data(), audioData: Data(), oldCondition: false, conditionLocation: [], totalSteps: 0, totalTime: 0)
    }
   
}
