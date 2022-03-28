//
//  LoadingScreen.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 10.02.2022.
//

import SwiftUI

struct LoadingScreen: View {
    var body: some View {
        ZStack{
            
            Color.white.ignoresSafeArea(.all, edges: .all)

            Image("FrameShagame")
                .frame(width: WIDTH * 0.68, height: HEIGHT * 0.46)
                .scaledToFill()
        }
    }
}

struct LoadingScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoadingScreen()
    }
}
