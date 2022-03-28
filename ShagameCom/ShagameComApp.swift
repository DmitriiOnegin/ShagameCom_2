//
//  ShagameComApp.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 29.01.2022.
//

import SwiftUI
import Firebase

@main
struct ShagameComApp: App {
    
   // @StateObject var navigationViewModel = NavigationViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AuthViewModel.shared)
                .environmentObject(NavigationViewModel())
        }
    }
}
