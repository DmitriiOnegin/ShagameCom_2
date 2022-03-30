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
    
    @EnvironmentObject var viewModel: BoxesViewModel
    //@ObservedObject var viewModel = BoxesViewModel.shared
    
    @ObservedObject var viewModelScreen = DescriptionScreenViewModel()
    
    @State private var showMainMenu = false
    
    init(authViewModel: AuthViewModel) {
        self.authViewModel = authViewModel
    }
    
    var body: some View {
        
        NavigationView {
            
            ZStack{
                BackgroundImage(id: viewModelScreen.descriptionScreen.titul.id)
               
                VStack{
                    Spacer()
                    Image(viewModelScreen.descriptionScreen.titul.mainImage)
                        .frame(width: WIDTH * 0.68, height: HEIGHT * 0.46)
                        .scaledToFill()
                        
                    Spacer()
                    Group{
                        Text(viewModelScreen.descriptionScreen.titul.title)
                            .font(fontBold16)
                            .lineLimit(10)
                            .foregroundColor(viewModelScreen.descriptionScreen.titul.id == 0 ? .white : .black)
                            .frame(height: HEIGHT / 17)
                    Spacer()
                        Text(viewModelScreen.descriptionScreen.titul.subTitle)
                            .font(fontLight16)
                            .foregroundColor(viewModelScreen.descriptionScreen.titul.id == 0 ? .white : .black)
                            .lineLimit(10)
                            .multilineTextAlignment(.center)
                            .frame(height: HEIGHT / 6)
                    }
//                    .padding(30)
                    Spacer()
                    Image("shg tag big")
                    Spacer()
                    Button {
                        navigationViewModel.navigation = .audioteka
                        navigationViewModel.showLink = true
                    } label: {
                        Image("btn - MainView")
                    }
                    Spacer()
                    NavigationLink(isActive: $navigationViewModel.showLink, destination: {
                        switch navigationViewModel.navigation {
                        case .profile:
                            SelfProfileView(allBoxes: viewModel.allBoxes)
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
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showMainMenu.toggle()
                    } label: {
                        Image(showMainMenu ? "close" : "burger menu")
                    }
                }
            }
        }
    }
}
