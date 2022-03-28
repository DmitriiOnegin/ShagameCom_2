//
//  BoxesViewModel.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 05.02.2022.
//

import Foundation

class BoxesViewModel: ObservableObject {
    
    @Published var allBoxes = [BoxViewModel]()
    
    static let shared = BoxesViewModel()
    
    private init() {
        
        fetchAllBoxes()
    }
    
    func fetchAllBoxes(){
        allBoxes.removeAll()
        NetworkManager.shared.fetchAllBoxes { result in
            switch result {
            case .success(let boxes):
                boxes.forEach { box in
                    self.allBoxes.append(BoxViewModel(box: box))
                }
            case .failure(_):
                do {}
            }
        }
    }
}


