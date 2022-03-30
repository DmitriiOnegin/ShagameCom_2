//
//  ProfileViewModel.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 03.02.2022.
//

import Foundation

class ProfileViewModel: ObservableObject {
    //@Published var user = User.getUser()
    //@Published var ownBoxes = [BoxViewModel]()
    //@Published var favoriteBoxes = [BoxViewModel]()
    let user: User
    
    init(user: User) {
        self.user = user
    }
    
    func getUserBoxes(allBoxes: [BoxViewModel]) -> [BoxViewModel] {
       
        return allBoxes.filter{$0.box.ownerUid == user.id}.sorted{$0.box.timestamp.description > $1.box.timestamp.description}
    }
    
    
}
