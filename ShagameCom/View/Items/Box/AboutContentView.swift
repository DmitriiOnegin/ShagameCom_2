//
//  AboutContentView.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 14.02.2022.
//

import SwiftUI

struct AboutContentView<Content: View> : View {
    var content: () -> Content
    var body: some View {
        return Group {
           
                
                ZStack{
                    Color.white.opacity(1.0)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    self.content()
                        .clipped()
                    
                }
            
        }
    }
}

struct AboutContentView_Previews: PreviewProvider {
    static var previews: some View {
        AboutContentView {
            ScrollView{
                VStack(spacing: 15){
            Text("Ахматова: я была дерзкой")
            .font(fontBold16)
            Text("Спектакль начинается\nвоспоминаниями о черноморском\nдетстве Ахматовой, сменяется\nюношеской любовью Анны и приводит\nк страшным событиям 30-х\nгодов двадцатого века.")
                .multilineTextAlignment(.center)
                .font(fontLight16)
                }
            Image("Group")
            Text("Автор")
                .font(fontBold16)
            Button(action: {}) {
                Text("Дина Верютина")
                    .font(fontLight16)
                    .foregroundColor(.gray)
            }
            Image("Group-1")
            Text("Длительность")
                .font(fontBold16)
            Text("90-120 минут\nили\n≈8 300 шагов")
                .multilineTextAlignment(.center)
                .font(fontLight16)
                .foregroundColor(.gray)
            VStack{
                Image("Vector 1")
                Text("Автор предлагает маршрут\nк этому аудиобоксу")
                    .multilineTextAlignment(.center)
                    .font(fontLight16)
                    .foregroundColor(.customRed)
            }
                VStack{
                    Button(action: {}) {
                        Image("btn - Edit Profile-5")
                    }
                    
                    Button(action: {}) {
                        Image("btn - Edit Profile-6")
                    }
                    Button(action: {}) {
                        Image("btn - Edit Profile-7")
                    }
                }
            }
        }
    }
}
