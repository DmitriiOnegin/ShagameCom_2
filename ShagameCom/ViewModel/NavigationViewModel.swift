//
//  NavigationViewModel.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 03.02.2022.
//

import Foundation
import UIKit

class NavigationViewModel: ObservableObject {
    
    @Published var navigation = Navigation.main
   //  var showMainMenu = false
    @Published var showLink = false
    
    func pressButton() {
        switch navigation {
        case .main:
            navigation = .main
        case .profile:
            navigation = .profile
        case .audioteka:
            navigation = .audioteka
        case .constructor:
            navigation = .constructor
        case .support:
            navigation = .support
        case .aboutProject:
            navigation = .aboutProject
        }
    }
    
    
}
