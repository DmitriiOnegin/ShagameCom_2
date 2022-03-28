//
//  SupportView.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 06.02.2022.
//

import SwiftUI

struct SupportView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    
    @State private var showNext = false
    
    @State private var showMainMenu = false
    
    var body: some View {
        ZStack{
           
        VStack{
            
            

            Text("vxdxv")
            


        Text("SupportView")
            .navigationTitle("Поддержка")
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

struct SupportView_Previews: PreviewProvider {
    static var previews: some View {
        SupportView()
    }
}
