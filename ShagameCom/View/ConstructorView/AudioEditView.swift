//
//  AudioEditView.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 10.02.2022.
//

import SwiftUI

struct AudioEditView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    
    @ObservedObject var viewModel: NewBoxViewModel
    
    @State private var showMainMenu = false
    @State private var showDetaleEditView = false
    
//    init(viewModel: NewBoxViewModel) {
//        self.viewModel = viewModel
//    }
    
    var body: some View {
        ZStack{
            
            VStack(spacing: 0) {
                HeadLittle(title: viewModel.newBox.title.isEmpty ? "Новый аудиобокс_1" : viewModel.newBox.title)
                
                ScrollView{
                    VStack(spacing: 20)  {
                        
                        Text("Аудио микшер. \nДобавляем аудио файл в viewModel: NewBoxViewModel")
                          
                        Spacer()
                    }
                    .padding(.top, 10)
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(showMainMenu ? true : false)
            .toolbar {
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.addAudioData()
                        showDetaleEditView.toggle()
                    } label: {
                        Image(showMainMenu ? "" : "download")
                    }
                }
                
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
                .ignoresSafeArea()
            }
            NavigationLink(isActive: $showDetaleEditView) {
                DetaleEditView(viewModel: viewModel)
            } label: {
                EmptyView()
            }
            }.ignoresSafeArea()
        
    }
}

//struct AudioEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        AudioEditView()
//    }
//}
