//
//  DescriptionViewModel.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 02.02.2022.
//

import Foundation

class DescriptionScreenViewModel: ObservableObject {
    @Published var descriptionScreen = Description.firstScreen
    
    func secondScreen() {
        switch descriptionScreen {
        case .firstScreen:
            descriptionScreen = .secondScreen
        case .secondScreen:
            descriptionScreen = .thirdScreen
        case .thirdScreen:
            descriptionScreen = .firstScreen
        
        }
    }
}
