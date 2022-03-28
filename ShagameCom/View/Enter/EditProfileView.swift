//
//  EditProfileView.swift
//  ShagameCom
//
//  Created by Arslan Abdullaev on 08.02.2022.
//

import SwiftUI

struct EditProfileView: View {
    let text = "Ваш профиль"
    
    @State private var login = ""
    @State private var email = ""
    @State private var fullName = ""
    @State private var passwordEnter: String = ""
    @State private var work = ""
    @State private var town = ""
    
    @State private var showMainMenu = false
    
    @ObservedObject var viewModel: SelfProfileViewModel
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    
    var body: some View {
       
        ZStack{
            
        VStack(spacing: 0) {
            HeadBig(title: "")
        
        ScrollView{
            VStack{
                
                
                Text(text)
                    .font(fontMedium16)
                    .padding(.trailing, 270)
                    .frame(width: WIDTH * 0.91)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .padding()
                
                TextFieldView(subtitle: "Логин", text: $login)
                TextFieldView(subtitle: "Email", text: $email)
                TextFieldView(subtitle: "Пароль", text: $passwordEnter)
                TextFieldView(subtitle: "Имя пользователя", text: $fullName)
                TextFieldView(subtitle: "Занятость", text: $work)
                TextFieldView(subtitle: "Местоположение", text: $town)
                
            }
            .frame(width: WIDTH * 0.91, height: 500)
            .padding(.top, 60)
            
            Button {
                viewModel.editUserData(fullName: fullName, town: town, work: work) {
                    presentationMode.wrappedValue.dismiss()
                }
            } label: {
                Image("btn - Edit Profile-2")
            }
            .padding(.top, 60)
            
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
        }
        .ignoresSafeArea()
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
        .onAppear {
            email = viewModel.user.email
            fullName = viewModel.user.fullName
            work = viewModel.user.work
            town = viewModel.user.town
        }
    }
}


//struct EditProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditProfileView()
//    }
//}
