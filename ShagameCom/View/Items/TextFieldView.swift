//
//  TextFieldView.swift
//  ShagameCom
//
//  Created by Arslan Abdullaev on 07.02.2022.
//

import SwiftUI

struct TextFieldView: View {
    
    var subtitle: String
    
    @Binding var text: String
   // @State var isTapped = false
    
    var body: some View {
        VStack(alignment: .leading, content: {
            
            HStack(spacing: 15){
                TextField("", text: $text) { (status) in
//                    if status {
//                     //   withAnimation(.easeIn){
//                            isTapped = true
//                      //  }
//                    }
                } onCommit: {
//                    if text == "" {
//                      //  withAnimation(.easeOut){
//                            isTapped = false
//                       // }
//                    }
                }
                .font(fontMedium16)
                .foregroundColor(.sh_basicGrey)
                
                if subtitle == "Пароль" {
                    Button {
                        
                    } label: {
                        Image("Eye")
                    }
                }
                Button {
                    
                } label: {
                    Image("outline-check-24px")
                }
            }
//            .padding(.top, isTapped ? 9 : 0)
            .padding(.top, 9)
            .background(
                Text(subtitle)
                    .font(fontRegular12)
                  //  .scaleEffect(1.3)
                    .offset(x: 10, y: -15)
                    .foregroundColor(.sh_basicGrey)
                ,alignment: .leading
            )
        })
        
            .padding(.vertical,20)
            .padding(.horizontal)
            .background(RoundedRectangle(cornerRadius: 5).strokeBorder())
    }
}

