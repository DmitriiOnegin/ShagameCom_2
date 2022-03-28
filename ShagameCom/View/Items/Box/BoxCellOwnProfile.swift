//
//  BoxCellOwnProfile.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 14.02.2022.
//

import SwiftUI

struct BoxCellOwnProfile: View {
    
    let box: Box
    
    var body: some View {
//        VStack(alignment: .center, spacing: 17) {
//            Image("TestImage")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: WIDTH / 5)
//            Text(box.title)
//                .font(fontBold12)
//                .multilineTextAlignment(.center)
//                .lineLimit(2)
//                .frame(width: WIDTH / 5)
//            Image("check 1")
//        }
        VStack(alignment: .center, spacing: 17) {
            Image("TestImage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: WIDTH * 0.24, height: WIDTH * 0.24 * 1.52)
//                .resizable()
//                .frame(width: WIDTH * 0.24, height: HEIGHT * 0.17)
//                .aspectRatio(contentMode: .fill)
                .clipShape(RoundedRectangle(cornerRadius: 23))
                
            Text(box.title)
                .font(fontBold12)
                .foregroundColor(.customGray)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(width: WIDTH / 5, height: 42)
            Image("check 1")
        }
        
    }
}

//struct BoxCellOwnProfile_Previews: PreviewProvider {
//    static var previews: some View {
//        BoxCellOwnProfile()
//    }
//}
