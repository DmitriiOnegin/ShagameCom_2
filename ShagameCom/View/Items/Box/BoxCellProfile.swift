//
//  BoxCellProfile.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 14.02.2022.
//

import SwiftUI

struct BoxCellProfile: View {
    
    @ObservedObject var viewModel: BoxViewModel
    
    var body: some View {
        //VStack(alignment: .center, spacing: 17) {
        VStack(alignment: .center) {
//            Image("TestImage")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: WIDTH / 5)
            Image("TestImage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: WIDTH * 0.24, height: WIDTH * 0.24 * 1.52)
                .clipShape(RoundedRectangle(cornerRadius: 23))
//            Text(viewModel.box.title)
//                .font(fontBold12)
//                .multilineTextAlignment(.center)
//                .lineLimit(2)
//                .frame(width: WIDTH / 5)
            Text(viewModel.box.title)
                .font(fontBold12)
                .foregroundColor(.customGray)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(width: WIDTH / 5, height: 42)
            
            HStack{
                Text(viewModel.totalRatingString)
                    .font(fontBold12)
                Image("rate")
                Text("\(viewModel.box.totalViews)")
                    .font(fontLight12)
            }
            .foregroundColor(.red)
            
//            Text(viewModel.box.ownerFullName)
//                .font(fontLight12)
//                .multilineTextAlignment(.center)
//                .lineLimit(2)
//                .frame(width: WIDTH / 5)
            Text(viewModel.box.ownerFullName)
                .font(fontLight12)
                .foregroundColor(.customGray)
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .frame(width: WIDTH / 5, height: 25)
        }
    }
}

//struct BoxCellProfile_Previews: PreviewProvider {
//    static var previews: some View {
//        BoxCellProfile()
//    }
//}
