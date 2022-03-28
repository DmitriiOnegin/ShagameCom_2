//
//  DetaleEditView.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 10.02.2022.
//

import SwiftUI

struct DetaleEditView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    
    @ObservedObject var viewModel: NewBoxViewModel
    
    @State private var showMainMenu = false
    @State private var mainCondition = false
    @State private var title = ""
    @State private var description = ""
    
    var body: some View {
        ZStack{
            
            VStack(spacing: 0) {
                HeadLittle(title: "Публикация аудиобокса")
                
                ScrollView{
                    VStack(spacing: 20)  {
                        
                        VStack(spacing: 14) {
                           
                            TextFieldView(subtitle: "Название аудиобокса", text: $title)
                                
                                
                            TextFieldView(subtitle: "Краткое описание", text: $description)
                        }
                        .frame(width: WIDTH * 0.91, height: 160)
                        
                        HStack{
                            Spacer()
                            Button {
                                viewModel.addImageData()
                            } label: {
                                VStack{
                                    Text(viewModel.newBox.audioData != Data() ? "Аудио добавлено" : "Аудио НЕ добавлено")
                                    Text("Добавить обложку")
                                        .foregroundColor(viewModel.newBox.imageData != Data() ? .green : .blue)
                                }
                            }
                            Spacer()
                            
                            NavigationLink {
                                MapEditView(viewModel: viewModel)
                            } label: {
                                VStack{
                                    Text("Добавить")
                                    Text("Маршрут")
                                }
                                .foregroundColor(viewModel.newBox.conditionLocation.isEmpty ? .blue : .green)
                            }

//                            Button {
//                                viewModel.addLocationData()
//                            } label: {
//                                VStack{
//                                    Text("Добавить")
//                                    Text("Маршрут")
//                                }
//                                .foregroundColor(viewModel.newBox.conditionLocation.isEmpty ? .blue : .green)
//                            }
                            Spacer()
                        }
                        
                        
                        HStack{
                            
                            Toggle(isOn: $viewModel.newBox.oldCondition) {
                               
                            }
                            
                            VStack{
                                Text("18 лет")
                            }
                            Spacer()
                        }
                        HStack{
                            Button {
                                mainCondition.toggle()
                            } label: {
                                Image(mainCondition ? "Ok - Inactive-1" : "Ok - Inactive")
                            }
                            
                            VStack{
                                Text("Принять условия поьзовательского соглашения")
                            }
                            
                        }
                        Spacer()
                        Button {
                            viewModel.uploadBox {
                                navigationViewModel.navigation = .profile
                            }
                        } label: {
                            Image("btn - Edit Profile-3")
                        }
                        
                        Spacer()
                    }
                    .padding(.top, 10)
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
        }
        .onAppear(perform: {
            title = viewModel.newBox.title
            description = viewModel.newBox.description
        })
        .onDisappear(perform: {
            viewModel.newBox.title = title
            viewModel.newBox.description = description
        })
        .ignoresSafeArea()
    }
}

//struct DetaleEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetaleEditView()
//    }
//}
