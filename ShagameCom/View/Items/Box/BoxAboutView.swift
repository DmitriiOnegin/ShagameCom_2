//
//  BoxAboutView.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 14.02.2022.
//

import SwiftUI

struct BoxAboutView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    
    @ObservedObject var viewModel: BoxViewModel

    @State private var showMainMenu = false
    @State private var mainCondition = false
    @State private var title = ""
    @State private var description = ""
    
    
    var body: some View {
        
        ZStack{
            VStack(spacing: 0){
                HeadLittle(title: viewModel.box.title)
                ScrollView{
                   
                        VStack{
                            Image("image 2")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: WIDTH, height: HEIGHT * 0.61)
                           
        
                        AboutContentView{
                       
                            VStack{
                                Group{
                                    Handle()
                                        .padding(.top, 9)
                                        .padding(.bottom, 9)
                                    VStack(spacing: 15){
                                        Text(viewModel.box.title)
                                            .multilineTextAlignment(.center)
                                            .font(fontBold16)
                                        Text(viewModel.box.description)
                                            .multilineTextAlignment(.center)
                                            .font(fontLight16)
                                    }
                                    .foregroundColor(.customGray)
                                    .padding(.horizontal, 45)
                                    
                                    VStack(spacing: 10){
                                        Image("Group")
                                        Text("Автор")
                                            .font(fontBold16)
                                            .foregroundColor(.customGray)
                                    }.padding(.top, 20)
                                    NavigationLink {
                                        ProfileView(user: viewModel.box.ownerUser ?? User.getUser())
                                    } label: {
                                        Text(viewModel.box.ownerUser?.fullName ?? "")
                                            .underline(true, color: .customGray)
                                            .font(fontLight16)
                                            .foregroundColor(.customGray)
                                    }.padding(.top, 10)
                                    VStack(spacing: 5){
                                        Image("Group-1")
                                        Text("Длительность")
                                            .font(fontBold16)
                                            .foregroundColor(.customGray)
                                    }.padding(.top, 20)
                                    Text("90-120 минут\nили\n≈8 300 шагов")
                                        .multilineTextAlignment(.center)
                                        .font(fontLight16)
                                        .foregroundColor(.customGray)
                                        .padding(.top, 20)
                                    VStack{
                                        Image("Vector 1")
                                        Text("Автор предлагает маршрут\nк этому аудиобоксу")
                                            .multilineTextAlignment(.center)
                                            .lineLimit(2)
                                            .font(fontLight16)
                                            .foregroundColor(.customRed)
                                    }.padding(.top, 20)
                                    VStack(spacing: 5){
                                        NavigationLink {
                                            BoxPlayerView(box: viewModel.box, typePleerView: .map)
                                        } label: {
                                            Image("btn - Edit Profile-5")
                                        }
                                        
                                        NavigationLink {
                                            BoxPlayerView(box: viewModel.box, typePleerView: .player)
                                        } label: {
                                            Image("btn - Edit Profile-6")
                                        }
                                        .padding(.top, 10)
                                        
                                        Button(action: {}) {
                                            Image("btn - Edit Profile-7")
                                        }
                                    }.padding(.top, 20)
                                        .padding(.bottom, 60)
                                    
                                }
                                Spacer()
                            }
                        }
                        }
                }
                .frame(maxHeight: 3000)
            }
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
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image("go back")
                    }
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


