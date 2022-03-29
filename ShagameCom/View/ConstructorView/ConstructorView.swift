//
//  ConstructorView.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 06.02.2022.
//

import SwiftUI

struct ConstructorView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    
   // @ObservedObject var viewModel = NewBoxesViewModel.shared
    
    @State private var showMainMenu = false
    
    let ownBoxes: [BoxViewModel]
   
    var body: some View {
        ZStack{
            
            VStack(spacing: 0) {
                HeadBig(title: "Конструктор")
                
                ScrollView{
                    VStack(spacing: 30)  {
                        HStack{
                            Text("Создайте свой аудиобокс, наполните его и\nразместите на карте.\nВы можете записать голос при помощи\nвстроенного диктофона, выбрать музыкальное\nсопровождение из нашего каталога, создать\nатмосферу при помощи звуков и шумов,\nкоторые мы для вас приготовили.\nРедактируйте ваши записи, при помощи\nинструментов и эффектов.")
                                .multilineTextAlignment(.leading)
                                .font(fontLight16)
                                .foregroundColor(.customGray)
                                .lineLimit(10)
                                .padding(.leading, 15)
                            Spacer()
                        }.padding(.top, 30)
                      
                        VStack(alignment: .center){
                            NavigationLink {
                                
                            } label: {
                                Image("Group 141")
                            }
                        }
                        
                        //                            Text("Мои аудиобоксы")
                        HStack{
                            Text("Мои аудиобоксы")
                                .font(fontBold24)
                                .foregroundColor(.customGray)
                                .padding(.leading, 15)
                            Spacer()
                        }
                        
                        OwnAllBoxes(ownBoxes: ownBoxes)
                        
                        Spacer()
                    }
                    .padding(.top, 10)
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
        
        .ignoresSafeArea()
        .navigationBarTitleDisplayMode(.inline)
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
}

//struct ConstructorView_Previews: PreviewProvider {
//    static var previews: some View {
//        ConstructorView()
//    }
//}
