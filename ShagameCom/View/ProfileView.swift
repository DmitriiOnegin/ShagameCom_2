//
//  ProfileView.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 29.03.2022.
//

import SwiftUI

struct ProfileView: View {
    
    let user: User
   
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    @EnvironmentObject var boxesViewModel: BoxesViewModel
    
    @ObservedObject var viewModel: ProfileViewModel
   
    @State private var showMainMenu = false
    
    init(user: User) {
        self.user = user
        self.viewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
        ZStack{
            
            VStack(spacing: 0) {
                HeadBig(title: "")
                
                ZStack {
                    ScrollView(showsIndicators: false){
                            VStack(spacing: 20)  {
                                Group{
                                    Text("Имя: \(viewModel.user.fullName)")
                                        .font(fontBold28)
                                        .foregroundColor(.customGray)
                                    Text("Работа: \(viewModel.user.work)")
                                        .font(fontLight16)
                                        .foregroundColor(.customGray)
                                    Image("shg tag sm")
                                    Text("Город: \(viewModel.user.town)")
                                        .font(fontMedium12)
                                        .foregroundColor(.customRed)
                                }
                                
                                HStack{
                                    Text("Аудиобоксы автора")
                                        .font(fontBold24)
                                        .foregroundColor(.customGray)
                                    Spacer()
                                }
                                .padding(.leading, 15)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 30) {
                                        ForEach (viewModel.getUserBoxes(allBoxes: boxesViewModel.allBoxes)) { boxViewModel in
                                            NavigationLink {
                                                BoxMainView(viewModel: boxViewModel)
                                            } label: {
                                                BoxCellProfile(viewModel: boxViewModel)
                                            }
                                        }
                                    }
                                    .padding()
                                }
                                
                                Spacer()
                            }
                            .padding(.top, 80)
                    }
                    VStack{
                        Text("")
                            .frame(width: WIDTH ,height: 100)
                            .background(
                                LinearGradient(gradient:
                                                Gradient(colors: [.white.opacity(1), .white.opacity(0)]),
                                                startPoint: .top,
                                                endPoint: .bottom))
                                                Spacer()
                    }
                }
                    
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showMainMenu.toggle()
                    } label: {
                        Image(showMainMenu ? "close" : "burger menu")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image("go back")
                    }
                }
            }
            VStack{
                ProfilePhotoView(isEmpty: true)
                    .padding(.top, 50)
                Spacer()
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
        }.ignoresSafeArea()
    }
}
