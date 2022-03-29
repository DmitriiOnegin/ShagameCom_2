//
//  SelfProfileView.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 06.02.2022.
//

import SwiftUI

struct SelfProfileView: View {
    
    let authViewModel: AuthViewModel
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    
    @ObservedObject var viewModel: SelfProfileViewModel
   
    @State private var showMainMenu = false
    
    init(authViewModel: AuthViewModel, allBoxes: [BoxViewModel]) {
        self.authViewModel = authViewModel
        self.viewModel = SelfProfileViewModel(allBoxes: allBoxes)
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
                                    Text("Город: \(viewModel.user.town)")
                                        .font(fontMedium12)
                                        .foregroundColor(.customGray)
                                        .foregroundColor(.customRed)
                                }
                                NavigationLink {
                                    EditProfileView(viewModel: viewModel)
                                } label: {
                                    Image("btn - Edit Profile-4")
                                }
                                HStack(spacing: 10){
                                    Image("statistical 1")
                                    Text("Статистика")
                                        .font(fontBold24)
                                        .foregroundColor(.customGray)
                                    Spacer()
                                }.padding(.leading, 15)
                                
                                HStack(spacing: 40){
                                    VStack(spacing: 10){
                                        Text("Пройденных \nшагов")
                                            .font(fontLight12)
                                            .multilineTextAlignment(.center)
                                        Text("\(viewModel.user.countTotalSteps ?? 0)")
                                            .font(fontBold16)
                                    }
                                    VStack(spacing: 10){
                                        Text("Прослушанных \nаудиобоксов")
                                            .font(fontLight12)
                                            .multilineTextAlignment(.center)
                                        Text("\(viewModel.user.countListenBoxes ?? 0)")
                                            .font(fontBold16)
                                    }
                                    VStack(spacing: 10){
                                        Text("Созданных \nаудиобоксов")
                                            .font(fontLight12)
                                            .multilineTextAlignment(.center)
                                        Text("\(viewModel.user.countOwnBoxes ?? 0)")
                                            .font(fontBold16)
                                    }
                                }
                                .foregroundColor(.sh_basicRed)
                                
                                HStack{
                                    Text("Мои аудиобоксы")
                                        .font(fontBold24)
                                        .foregroundColor(.customGray)
                                    Spacer()
                                }
                                .padding(.leading, 15)
                                
                                OwnAllBoxes(ownBoxes: viewModel.ownBoxes)
        
                                HStack{
                                    Image("heart 2")
                                        .scaleEffect(1.5)
                                        .frame(width: WIDTH / 24, height: WIDTH / 24)
                                    Text("")
                                    Text("Избранное")
                                        .font(fontBold24)
                                        .foregroundColor(.customGray)
                                    Spacer()
                                }
                                .padding(.leading, 15)
                    
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 30) {
                                        ForEach (viewModel.favoriteBoxes) { boxViewModel in
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

