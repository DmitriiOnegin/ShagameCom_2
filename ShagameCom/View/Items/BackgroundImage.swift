//
//  BackgroundImage.swift
//  ShagameCom
//
//  Created by Arslan Abdullaev on 04.02.2022.
//

import SwiftUI

struct BackgroundImage: View {
    
    var id: Int
    
    var body: some View {
        ZStack{
            
        Image("background")
            .resizable()
            .ignoresSafeArea()
            VStack{
            if id == 1 {
                
            Circle()
                    .frame(width: WIDTH * 1.9)
                .foregroundColor(.white)
                    .offset(x: 100, y: 300)
              
            } else if id == 2 {
                Circle()
                    .frame(width: WIDTH * 1.9)
                    .foregroundColor(.white)
                    .offset(x: -100, y: 300)
                }
            } .frame(width: WIDTH)
        }
    }
}

struct BackgroundImage_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundImage(id: 1)
    }
}
