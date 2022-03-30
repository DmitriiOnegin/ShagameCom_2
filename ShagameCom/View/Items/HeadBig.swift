//
//  HeadBig.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 10.02.2022.
//

import SwiftUI

//let cooficient: CGFloat = HEIGHT / CGFloat(812)
let cooficient = Double(HEIGHT) / Double(812)
let cooficientW = Double(WIDTH) / Double(375)

struct HeadBig: View {
    
    let cooficient = Double(HEIGHT) / Double(812)
    
    let title: String
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.customRed)
                .frame(width: WIDTH, height:  176 * cooficient)
            Text(title)
                .font(fontBold28)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.white)
                .padding(.leading, 20)
                .padding(.top, 70)
        }
    }
}

struct HeadBig_Previews: PreviewProvider {
    static var previews: some View {
        HeadBig(title: "Регистрация")
    }
}
