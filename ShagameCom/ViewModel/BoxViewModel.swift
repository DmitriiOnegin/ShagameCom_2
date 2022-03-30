//
//  BoxViewModel.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 03.02.2022.
//

import Foundation

class BoxViewModel: ObservableObject, Identifiable {
    let id = UUID()
    @Published var box: Box
    
    var didFavorite: Bool {
        box.didFavorite ?? false
    }
    
    var didOpen: Bool {
        box.didOpen ?? false
    }
    
    var isMarshrut: Bool {
        box.conditionLocation.count > 1
    }
    
    var totalRatingString: String {
        String(format: "%.1f", box.totalRating[0])
    }
    
    
    init(box: Box) {
        self.box = box
        
        checkBox()
    }
    
    func checkBox(){
        checkIfUserIsFavoritBox()
        checkIfUserDidOpenBox()
        fetchUser()
//
//        fetchOwnerData()
//
    }
    
    private func checkIfUserIsFavoritBox() {
        NetworkManager.shared.checkIfUserIsFavoritBox(box: box) { result in
            switch result {
            case .success(let didFavorite):
                self.box.didFavorite = didFavorite
            case .failure(_):
                do {}
            }
        }
    }
    
    private func didFavoritBox() {
        NetworkManager.shared.didFavoritBox(box: box) { result in
            switch result {
            case .success(let didFavorite):
                self.box.didFavorite = didFavorite
            case .failure(_):
                do {}
            }
        }
    }
    
    private func didUnfavoritBox() {
        NetworkManager.shared.didUnfavoritBox(box: box) { result in
            switch result {
            case .success(let didFavorite):
                self.box.didFavorite = didFavorite
            case .failure(_):
                do {}
            }
        }
    }
    
    
    private func checkIfUserDidOpenBox() {
        NetworkManager.shared.checkIfUserDidOpenBox(box: box) { result in
            switch result {
            case .success(let didOpen):
                self.box.didOpen = didOpen
            case .failure(_):
                do {}
            }
        }
    }
    
    func didOpenBox() {
        NetworkManager.shared.didOpenBox(box: box) { result in
            switch result {
            case .success(let didOpen):
                self.box.didOpen = didOpen
            case .failure(_):
                do {}
            }
        }
    }
    
    func isFavoritBox() {
        guard let didFavorite = box.didFavorite else { return }
        didFavorite ? didUnfavoritBox() : didFavoritBox()
    }
    
   private func editBoxData() {
        NetworkManager.shared.editBoxData(box: box) { result in
            switch result {
            case .success(_):
                do {}
            case .failure(_):
                do {}
            }
        }
    }
    
    func editRatingBox(rating: Double) {
        guard let oldRating = box.totalRating.first else { return }
        guard let oldCount = box.totalRating.last else { return }
        let newRating = (oldRating * oldCount + rating) / (oldCount + 1)
        box.totalRating[0] = newRating
        box.totalRating[1] = oldCount + 1
        editBoxData()
    }
    
    func editViewsBox() {
        box.totalViews += 1
        editBoxData()
    }
    
    private func fetchUser() {
        NetworkManager.shared.fetchUser(userID: box.ownerUid) { result in
            switch result {
            case .success(let user):
                self.box.ownerUser = user
            case .failure(_):
                do {}
            }
        }
    }
    
}
