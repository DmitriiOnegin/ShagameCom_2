//
//  DescriptionView.swift
//  ShagameCom
//
//  Created by Arslan Abdullaev on 04.02.2022.
//

import SwiftUI

struct DescriptionView: View {
    
    @ObservedObject var viewModel = DescriptionScreenViewModel()
    
    var body: some View {
        ZStack{
            BackgroundImage(id: viewModel.descriptionScreen.titul.id)
            VStack {
                Image(viewModel.descriptionScreen.titul.mainImage)
                    .frame(width: WIDTH * 0.68, height: HEIGHT * 0.46)
                    .scaledToFill()
                    .padding(.top, 37)
                Spacer()
                VStack(alignment: .center){
                Text(viewModel.descriptionScreen.titul.title)
                    .font(fontBold16)
                    .lineLimit(10)
                    .foregroundColor(viewModel.descriptionScreen.titul.id == 0 ? .white : .black)
                    .frame(height: HEIGHT / 17)
                Text(viewModel.descriptionScreen.titul.subTitle)
                    .font(fontLight16)
                    .foregroundColor(viewModel.descriptionScreen.titul.id == 0 ? .white : .black)
                    .lineLimit(10)
                    .multilineTextAlignment(.center)
                    .frame(height: HEIGHT / 6)
                }
                .padding(30)
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        viewModel.secondScreen()
                    } label: {
                        Image(viewModel.descriptionScreen.titul.buttonIcon)
                    }
                    .padding(.trailing, 20)
                }
            }
          // .padding(12)
        }
    }
}

struct DescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionView()
    }
}
