//
//  RegisterView.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 10.02.2022.
//

import SwiftUI

struct RegisterView: View {
    
    
    
    var title = "Регистрация"
    
    @State private var email = ""
    @State private var fullName = ""
    @State private var passwordEnter: String = ""
    @State private var passwordConformed: String = ""
    @State private var showAlert: Bool = false
    @State private var showLoginView = false
    @State private var offsetValue: CGFloat = 0.0
    
   // @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HeadBig(title: title)
              
        ScrollView{
            
           HeadSocial()
            
            VStack(spacing: 14) {
                TextFieldView(subtitle: "Логин", text: $fullName)
                TextFieldView(subtitle: "Email", text: $email)
                TextFieldView(subtitle: "Пароль", text: $passwordEnter)
            }
            .frame(width: WIDTH * 0.91, height: 240)
            .padding(.top)
            HStack {
                Spacer()
                
                Button {
                    showLoginView.toggle()
                } label: {
                    HStack {
                    Text("Уже есть аккаунт?")
                        .font(fontMedium16)
                        .foregroundColor(.black)
                    Image("round-arrow_right_alt-24px")
                    }
                }
                .padding(.trailing,15)
               
            } .padding(.bottom,40)
            Button {
               // if passwordEnter == passwordConformed {
                    viewModel.register(withEmail: email, password: passwordEnter)
//                } else {
//                    self.showAlert.toggle()
//                }
            } label: {
                Image("btn - Edit Profile")
            }
            .alert(isPresented:$showAlert) {
                Alert(
                    title: Text("Пароли не совпадают"),
                    message: Text("Повторите ввод паролей"),
                    
                    dismissButton: .cancel(Text("Ok"))
                )
            }
        }
        .frame(height: HEIGHT * 0.8)
        .keyboardSensible($offsetValue)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                } label: {
                    Image("burger menu")
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    
                } label: {
                    Image("go back")
                }
            }
        }
                NavigationLink(isActive: $showLoginView) {
                    LoginView()
                } label: {
                    EmptyView()
                }

            }
            .ignoresSafeArea()
        }
    }
}
