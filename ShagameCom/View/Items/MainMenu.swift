//
//  MainMenu.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 06.02.2022.
//

import SwiftUI

struct MainMenu: View {
    
    @EnvironmentObject var viewModel: NavigationViewModel
   // let authViewModel: AuthViewModel
    
    @Binding var showMainMenu: Bool
//    @Binding var showLink: Bool
    
    var body: some View {
       
        VStack(alignment: .leading, spacing: 20) {
//            HStack{
            Button {
                viewModel.navigation = .profile
                showMainMenu.toggle()
                viewModel.showLink = true
               
            } label: {
               StrokItem(text: Navigation.profile.rawValue,
                                  color: viewModel.navigation == .profile ? .red : .black)}
 //           .padding(.trailing, 40)
//                Button {
//                    showMainMenu.toggle()
//                } label: {
//                    Image("")
//                }
//            }
            
            Button {
                viewModel.navigation = .audioteka
                showMainMenu.toggle()
                viewModel.showLink = true
            } label: {
                StrokItem(text: Navigation.audioteka.rawValue,
                                  color: viewModel.navigation == .audioteka ? .red : .black)}
            
            Button {
                viewModel.navigation = .constructor
                showMainMenu.toggle()
                viewModel.showLink = true
            } label: {
                StrokItem(text: Navigation.constructor.rawValue,
                                  color: viewModel.navigation == .constructor ? .red : .black)}
            
            Button {
                viewModel.navigation = .support
               showMainMenu.toggle()
                viewModel.showLink = true
            } label: {
                StrokItem(text: Navigation.support.rawValue,
                                  color: viewModel.navigation == .support ? .red : .black)}
            
            Button {
                viewModel.navigation = .aboutProject
                showMainMenu.toggle()
                viewModel.showLink = true
            } label: {
                StrokItem(text: Navigation.aboutProject.rawValue,
                                  color: viewModel.navigation == .aboutProject ? .red : .black)}
           
//            NavigationLink(destination: {
//                SelfProfileView()
//            }, label: { StrokItem(text: Navigation.profile.rawValue,
//                                  color: viewModel.navigation == .profile ? .red : .black)})
//
//            NavigationLink(destination: {
//                AudiotekaView()
//            }, label: { StrokItem(text: Navigation.audioteka.rawValue,
//                                  color: viewModel.navigation == .audioteka ? .red : .black)})
//
//            NavigationLink(destination: {
//                ConstructorView()
//            }, label: { StrokItem(text: Navigation.constructor.rawValue,
//                                  color: viewModel.navigation == .constructor ? .red : .black)})
//
//            NavigationLink(destination: {
//             SupportView()
//            }, label: { StrokItem(text: Navigation.support.rawValue,
//                                  color: viewModel.navigation == .support ? .red : .black)})
//
//            NavigationLink(destination: {
//             AboutProjectView()
//            }, label: { StrokItem(text: Navigation.aboutProject.rawValue,
//                                  color: viewModel.navigation == .aboutProject ? .red : .black)})
   
        }
        .padding(.top, 100)
        .padding(.bottom, 40)
        .padding(.leading, 40)
        .padding(.trailing, 120)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
        )
        .offset(x: 20, y: 0)
        //.padding(.horizontal)
    }
    
}

struct StrokItem: View {
    
    let text: String
    let color: Color
    
    var body: some View {
        
            Text(text)
                .foregroundColor(color)
                .font(fontMedium16)
                .multilineTextAlignment(.leading)
    }
}
