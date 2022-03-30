//
//  SelfProfileViewModel.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 03.02.2022.
//

import Foundation

class SelfProfileViewModel: ObservableObject {
   
    @Published var user = User.getUser()
    @Published var ownBoxes = [BoxViewModel]()
    @Published var favoriteBoxes = [BoxViewModel]()
    
    let allBoxes: [BoxViewModel]
    
    init(allBoxes: [BoxViewModel]) {
        self.allBoxes = allBoxes
        fetchUser()
//        getOwnBoxes()
//        getFavoriteBoxes()
    //    getUidDidOpenBoxes()
    }
    
    func editUserImage(imageData: Data, completion: @escaping (Bool) -> Void){
        
    }
    
    func editUserData(fullName: String, town: String, work: String, completion: @escaping () -> Void){
        NetworkManager.shared.editUserData(fullName: fullName, town: town, work: work) { result in
            switch result {
            case .success(let user):
                self.user = user
                completion()
                
            case .failure(_):
                do {}
            }
        }
    }
    
    
    
//    func getFavoriteBoxes() {
//        NetworkManager.shared.fetchUidIsFavoritBoxes { result in
//            switch result {
//            case .success(let favoritBoxesUid):
//                favoritBoxesUid.forEach { uid in
//                    let box = self.allBoxes.filter{ $0.box.id == uid }
//                    self.favoriteBoxes += box
//                }
//            case .failure(_):
//                do {}
//            }
//        }
//    }
    
    func getFavoriteBoxes() {
        favoriteBoxes = allBoxes.filter{ $0.didFavorite == true }
    }
    
    private func getOwnBoxes() {
        ownBoxes = allBoxes.filter{ $0.box.ownerUid == user.id }
        user.countOwnBoxes = ownBoxes.count
    }
    
    private func getUidDidOpenBoxes() {
        NetworkManager.shared.fetchUidDidOpenBoxes { result in
            switch result {
            case .success(let didOpenBoxesUid):
                self.user.countListenBoxes = didOpenBoxesUid.count

            case .failure(_):
                do {}
            }
        }
    }
    
    func fetchUser() {
        guard let user = AuthViewModel.shared.currentUser else { return }
        NetworkManager.shared.fetchUser(userID: user.id) { result in
            switch result {
            case .success(let user):
                self.user = user
                self.getOwnBoxes()
                self.getFavoriteBoxes()
                self.getUidDidOpenBoxes()
            case .failure(_):
                do {}
            }
        }
    }
    
    
}
