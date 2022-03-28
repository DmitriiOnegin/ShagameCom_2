//
//  PasswordRecoveryView.swift
//  ShagameCom
//
//  Created by Arslan Abdullaev on 08.02.2022.
//

import SwiftUI

struct PasswordRecoveryView: View {
    var title = "Восстановление пароля"
    let subtitle = "Введите email-адрес, который вы указали\nпри регистрации. Мы отправим инструкции\nдля сброса пароля на ваш email."
    
    @State private var email = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 0) {
            HeadBig(title: title)
        ScrollView {
            Text(subtitle)
                .multilineTextAlignment(.leading)
                .lineLimit(4)
                .font(fontMedium16)
                .padding(.top, 30)
                .padding(.trailing, 30)
            TextFieldView(subtitle: "Email", text: $email)
                .frame(width: WIDTH * 0.91, height: 80)
            Button {
                
            } label: {
                Image("btn - Edit Profile-1")
            }.padding(.top, 60)

        }
            
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

struct PasswordRecoveryView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordRecoveryView()
    }
}
