//
//  User.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 02.02.2022.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
   // var id = UUID()
    @DocumentID var id: String?
    let email: String
    let fullName: String
    let profileImageUrl: String
    let town: String
    let work: String
   
    var isStopList: Bool? = false
   
    var isCurrentUser: Bool { return AuthViewModel.shared.userSession?.uid == id }
    
    var countTotalSteps: Int? = 0
    var countListenBoxes: Int? = 0
    var countOwnBoxes: Int? = 0
    
//    var ownBoxes: [Box]? = []
//    var favoriteBoxes: [Box]? = []
    
    static func getUser() -> User {
        User(email: "", fullName: "", profileImageUrl: "", town: "", work: "")
    }
    
}
