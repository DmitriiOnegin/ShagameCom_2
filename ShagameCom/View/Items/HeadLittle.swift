//
//  HeadLittle.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 11.02.2022.
//

import SwiftUI

struct HeadLittle: View {
    
    let title: String
    let cooficient = Double(HEIGHT) / Double(812)
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.customRed)
                .frame(width: WIDTH, height: 117 * cooficient)
               // .frame(width: WIDTH, height: 140 * cooficient)
            Text(title)
                .font(fontMedium16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.white)
                .padding(.leading, 83)
                .padding(.top, 35)
        }
    }
}

struct HeadLittle_Previews: PreviewProvider {
    static var previews: some View {
        HeadLittle(title: "HeadLittle")
    }
}
