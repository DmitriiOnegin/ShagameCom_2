//
//  HeadSocial.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 10.02.2022.
//

import SwiftUI

struct HeadSocial: View {
    
    let subtitle = "Войдите с помощью \nсоциальных сетей"
    let subtitleOr = "или"
    
    var body: some View {
        Text(subtitle)
            .multilineTextAlignment(.center)
            .lineLimit(2)
            .font(fontMedium16)
            .padding(.top, 30)
            .padding()
        
        HStack(spacing: 1) {
            Button {
            } label: {
                Image("Google")
            }
            Button {
                
            } label: {
                Image("Facebook")
            }
            Button {
                
            } label: {
                Image("vk")
            }
        }
        Text(subtitleOr)
            .multilineTextAlignment(.center)
            .lineLimit(2)
            .font(fontMedium16)
            .padding(.top, 25)
    }
}

struct HeadSocial_Previews: PreviewProvider {
    static var previews: some View {
        HeadSocial()
    }
}
