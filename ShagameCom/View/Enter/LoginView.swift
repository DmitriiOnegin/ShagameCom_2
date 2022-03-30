//
//  LoginView.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 10.02.2022.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var offsetValue: CGFloat = 0.0
    
   
    var title = "Вход"

    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            HeadBig(title: title)
        ScrollView{
            HeadSocial()
            VStack(spacing: 14) {
                
                TextFieldView(subtitle: "Email", text: $email)
                TextFieldView(subtitle: "Пароль", text: $password)
                
                    }
            .frame(width: WIDTH * 0.91, height: 160)
           
            HStack {
                Spacer()
                NavigationLink {
                    PasswordRecoveryView()
                } label: {
                    HStack {
                        Text("Забыли пароль?")
                            .font(fontMedium16)
                            .foregroundColor(.black)
                    Image("round-arrow_right_alt-24px")
                    }
                }
                .padding(.trailing,15)
            } .padding(.bottom,40)
            //
            Button {
                viewModel.login(withEmail: email, password: password)
            } label: {
                Image("btn - Login")
            }
        }
        .frame(height: HEIGHT * 0.8)
        .keyboardSensible($offsetValue)
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                } label: {
                    Image("burger menu")
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
       
    }
}
