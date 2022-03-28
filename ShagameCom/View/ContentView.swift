//
//  ContentView.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 29.01.2022.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group{
            if viewModel.userSession == nil {
                
                RegisterView()
            } else {
                if viewModel.currentUser != nil {
           
                    MainView(authViewModel: viewModel).ignoresSafeArea()
    //                EditProfileView()
                } else {
                    LoadingScreen()

                }
            }
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
