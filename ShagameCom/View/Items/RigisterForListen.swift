//
//  RigisterForListenView.swift
//  ShagameCom
//
//  Created by Arslan Abdullaev on 12.03.2022.
//

import SwiftUI

struct RigisterForListen: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.white)
            VStack(alignment: .center){
                VStack(alignment: .center, spacing: 15){
                Image("attention")
                Text("Зарегистрируйтесь, чтобы\nначать прослушивание")
                    .multilineTextAlignment(.center)
                    .font(fontMedium16)
            }
            HStack{
                Image("Group 8")
                    .padding(.top, 9)
                Image("Group 62")
            }
        }
            .padding(.top, 20)
        }.frame(width: WIDTH * 0.78, height: HEIGHT * 0.23)
    }
}

struct RigisterForListenView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()
        RigisterForListen()
        }
    }
}
