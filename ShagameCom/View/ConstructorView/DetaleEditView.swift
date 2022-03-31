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
            
            VStack(alignment: .center, spacing: 0) {
                HeadLittle(title: "Публикация аудиобокса")
                
                ScrollView{
                    VStack(spacing: 20)  {
                        
                        VStack(spacing: 14) {
                           
                            TextFieldView(subtitle: "Название аудиобокса", text: $title)
                            MultilineTextField(text: $description, subtitle: "Краткое описание")
                        }
                        .frame(width: WIDTH * 0.91, height: 160)
                        
                        HStack{
                            Spacer()
                            
                                VStack{
                                   // Text(viewModel.newBox.audioData != Data() ? "Аудио добавлено" : "Аудио НЕ добавлено")
                                    ZStack{
                                        Image("TestImage")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: WIDTH * 0.24, height: WIDTH * 0.24 * 1.52)
                                            .clipShape(RoundedRectangle(cornerRadius: 23))
                                        Button {
                                                viewModel.addImageData()
                                        } label: {
                                            Circle()
                                            .foregroundColor(Color(UIColor(red: 185/255, green: 26/255, blue: 24/255, alpha: 1)))
                                            .frame(width: WIDTH * 0.11 * cooficient, height: WIDTH * 0.11 * cooficient)
                                            .overlay (Image("Image"))
                                        }
                                        .offset(x: 45 * cooficient, y: 55 * cooficient)
                                    }
                                    Text("Изменить обложку")
                                        .font(fontRegular12)
                                        .foregroundColor(.sh_basicGrey)
                                }
                            
                            Spacer()
                            
                            NavigationLink {
                                MapEditView(viewModel: viewModel)
                            } label: {
                                VStack{
                                ZStack{
                                    Image("Mask Group-2")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: WIDTH * 0.24, height: WIDTH * 0.24 * 1.52)
                                        .clipShape(RoundedRectangle(cornerRadius: 23))
                                    Button(action: {}) {
                                            Circle()
                                            .foregroundColor(Color(UIColor(red: 185/255, green: 26/255, blue: 24/255, alpha: 1)))
                                            .frame(width: WIDTH * 0.11 * cooficient, height: WIDTH * 0.11 * cooficient)
                                            .overlay (Image("Choose navigate"))
                                        }
                                    .offset(x: 45 * cooficient, y: 55 * cooficient)
                                    }
                                    Text("Изменить маршрут")
                                        .font(fontRegular12)
                                        .foregroundColor(.sh_basicGrey)
                                }
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
                            Spacer(minLength: 40 * cooficientW)
                        }
                        
                        HStack(spacing: 30){
                                Toggle(isOn: $viewModel.newBox.oldCondition){
                                    
                                }.toggleStyle(SwitchToggleStyle(tint: .sh_basicRed))
                                HStack(spacing: 20){

                                    Text("Аудиобокс не подходит для\nслушателей младше 18 лет")
                                        .font(fontMedium12)
                                        .foregroundColor(.sh_basicGrey)
                                        .multilineTextAlignment(.leading)
                                        .frame(width: 170)
                                    Button(action: {
                                        //NotoficationView
                                        
                                    }) {
                                        Image("Info")
                                            .frame(width: 24, height: 24)
                                    }
                                }
                                .frame(width: 199, height: 35)
                                Spacer(minLength: 40 * cooficientW)
                        }.frame(height: 35)
                     
                        
                        HStack(spacing: 30){
                            Button {
                                mainCondition.toggle()
                            } label: {
                                Image(mainCondition ? "Ok - Inactive-1" : "Ok - Inactive")
                            }
                            
                            VStack{
                                Text("Я принимаю условия Пользовательского\nсоглашения и даю согласие на обработку\nмоих персональных данных в соответствии\nс Политикой конфиденциальности.")
                                    .font(fontMedium12)
                                    .foregroundColor(.sh_basicGrey)
                                    .multilineTextAlignment(.leading)
                                    .frame(width: 240)
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
