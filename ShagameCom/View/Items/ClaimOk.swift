//
//  ClaimOk.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 06.02.2022.
//

import SwiftUI

struct ClaimOk: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.white)
            VStack(alignment: .center){
                VStack(alignment: .center, spacing: 15){
                Image("attention")
                Text("Мы рассмотрим вашу жалобу в\nближайшее время")
                    .multilineTextAlignment(.center)
                    .font(fontMedium16)
            }
            
                Image("Group 6")
                    .padding(.top, 9)
            
        }
            .padding(.top, 20)
        }.frame(width: WIDTH * 0.78, height: HEIGHT * 0.23)
    }
}

struct ClaimOk_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()
        ClaimOk()
        }
    }
}
