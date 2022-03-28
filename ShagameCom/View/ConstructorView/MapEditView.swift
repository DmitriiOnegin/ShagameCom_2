//
//  MapEditView.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 10.02.2022.
//

import SwiftUI
import MapKit

struct MapEditView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    
    @ObservedObject var viewModel: NewBoxViewModel
    
    @State private var showMainMenu = false
   
    
    var body: some View {
        ZStack{
            VStack(spacing: 0) {
                HeadLittle(title: "Аудиотека")
                
                ViewAddMark(newBoxViewModel: viewModel)
                
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
                Spacer()
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

