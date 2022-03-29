//
//  BoxCellMap.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 14.02.2022.
//

import SwiftUI

struct BoxCellMap: View {
    
    @ObservedObject var viewModel: BoxViewModel
 
    var body: some View {

        VStack{
        HStack(alignment: .center){
            Spacer()
            HStack(spacing: 15){
            Image("TestImage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: WIDTH * 0.24, height: WIDTH * 0.24 * 1.52)
                .clipShape(RoundedRectangle(cornerRadius: 23))
                .shadow(color: .clear, radius: 0, x: 0, y: 4)
                .overlay(
                    Button(action: {
                        viewModel.isFavoritBox()
                    }, label: {
                        Image(viewModel.didFavorite ? "heart 2" : "heart 3")
                    })
                        .offset(x: 30, y: 60)
                   )
                .scaleEffect(1)
                
            
               
                VStack(alignment: .leading){
                HStack(spacing: 15){
                    VStack(alignment: .leading){
                    HStack{
                    VStack(alignment: .leading, spacing: 10){
                        Text(viewModel.box.title)
                            .font(fontBold16)
                            .foregroundColor(.customGray)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                            .padding(.top, 5)
                        VStack(alignment: .leading, spacing: 7){
                        Text(viewModel.box.ownerFullName)
                            .font(fontLight12)
                            .underline(true, color: .customGray)
                            .foregroundColor(.customGray)
                            .multilineTextAlignment(.leading)
                        HStack{
                                Image("Vector")
                                .scaleEffect(1.1)
                                Text("\(viewModel.box.totalTime) минут")
                                    .font(fontLight12)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(2)
                                    .foregroundColor(.red)
                                }
                            }
                        }
                        Spacer()
                        }
                    }.padding(.leading,18)
                    Spacer()
                    VStack{
                        Image(viewModel.isMarshrut ? "navigate" : "")
                        Image("rate")
                        Text(viewModel.totalRatingString)
                            .font(fontBold12)
                        Text("\(viewModel.box.totalViews)")
                            .font(fontRegular12)
                        
                    }
                    .foregroundColor(.red)
                }
                    Spacer()
                HStack(spacing: 18){
                    NavigationLink {
                    //    BoxMainView(viewModel: viewModel)
                        BoxAboutView(viewModel: viewModel)
                    } label: {
                        Image("btn - BoxCellMap")
                            .scaleEffect(1.1)
                    }

                    VStack{
                        Button {
                            
                        } label: {
                            Image("next 1")
                                .scaleEffect(1.1)
                        }
                        Text("поделиться")
                            .font(fontRegular8)
                            .foregroundColor(.red)
                    }
                }.padding(.leading, 18)
                        
                }
                
            }.frame(width: WIDTH * 0.832, height: HEIGHT * 0.198)
                .padding(.trailing, 30)
        }
        
        .frame(width: WIDTH, height: HEIGHT * 0.298)
        .background(Color.white.cornerRadius(25))
            
            Rectangle()
                .frame(width: WIDTH, height: 6)
                .foregroundColor(.customLightGray)
        }
        
    }
    
}

//struct BoxCellMap_Previews: PreviewProvider {
//    static var previews: some View {
//        BoxCellMap()
//    }
//}
