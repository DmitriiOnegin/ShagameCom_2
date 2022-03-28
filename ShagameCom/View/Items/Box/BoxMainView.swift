//
//  BoxMainView.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 14.02.2022.
//

import SwiftUI



struct BoxMainView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    
    @ObservedObject var viewModel: BoxViewModel
    
    @State private var showMainMenu = false
    var rating = 4.0
    
    var body: some View {
        ZStack{
            
            VStack(spacing: 0) {
                HeadBig(title: "")
                
                ZStack {
                    ScrollView{
                        Text("Rating: \(viewModel.box.totalRating[0])")
                        Text("Rating: \(viewModel.box.totalRating[1])")
                        Text("Views: \(viewModel.box.totalViews)")
                            .padding()
                        Button {
                            viewModel.editViewsBox()
                        } label: {
                            Text("didOpen")
                        }
                        .padding()
                        
                        Button {
                            viewModel.editRatingBox(rating: rating)
                        } label: {
                            Text("addRating")
                        }
                        
                        Button {
                            viewModel.isFavoritBox()
                        } label: {
                            Image(viewModel.didFavorite ? "heart 2" : "heart 3")
                        }
                        .padding()
                        
                    }
                    .padding(.top, 80)
                }
            }
            
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showMainMenu.toggle()
                    } label: {
                        Image(showMainMenu ? "close" : "burger menu")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image("go back")
                    }
                }
            }
            
            if showMainMenu {
                VStack{
                    HStack{
                        Spacer()
                        MainMenu(showMainMenu: $showMainMenu)
                    }
                    Spacer()
                }
            }
        }.ignoresSafeArea()
    }
}

//struct BoxMainView_Previews: PreviewProvider {
//    static var previews: some View {
//        BoxMainView()
//    }
//}
