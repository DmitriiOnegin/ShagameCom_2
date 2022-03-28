//
//  MainView.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 06.02.2022.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    let authViewModel: AuthViewModel
    
    @ObservedObject var viewModel = BoxesViewModel.shared
    
    @State private var showMainMenu = false
    
    init(authViewModel: AuthViewModel) {
        self.authViewModel = authViewModel
    }
    
    var body: some View {
        ZStack{
            
            NavigationView {
                VStack{
                    
                    VStack(spacing: 20){
                        Text("MainView")
                        Button {
                            viewModel.fetchAllBoxes()
                        } label: {
                            Text("fetchAllBoxes")
                        }
                        Button {
                            AuthViewModel.shared.signout()
                        } label: {
                            Text("LogOut")
                        }
                    }
                    
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                showMainMenu.toggle()
                            } label: {
                                Image(showMainMenu ? "close" : "burger menu")
                            }
                        }
                        //                    ToolbarItem(placement: .navigationBarLeading) {
                        //                        Button {
                        //
                        //                        } label: {
                        //                            Image("go back")
                        //                        }
                        //                    }
                    }
                    
                    NavigationLink(isActive: $navigationViewModel.showLink, destination: {
                        switch navigationViewModel.navigation {
                        case .profile:
                            SelfProfileView(authViewModel: authViewModel, allBoxes: viewModel.allBoxes)
                        case .audioteka:
                            AudiotekaView(allBoxes: viewModel.allBoxes)
                        case .constructor:
                            ConstructorView(ownBoxes: viewModel.allBoxes)
                        case .support:
                            SupportView()
                        case .aboutProject:
                            AboutProjectView()
                        default:
                            do {}
                        }
                    }, label: {EmptyView()})
                    
                }
            }
            if showMainMenu {
                VStack{
                    HStack{
                        Spacer()
                        MainMenu(showMainMenu: $showMainMenu)
                    }
                    Spacer()
                }
            }
        }
        .ignoresSafeArea()
        
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView(authViewModel: AuthViewModel())
//    }
//}
