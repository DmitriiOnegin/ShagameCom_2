//
//  BoxCellEdit.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 17.02.2022.
//

import SwiftUI

struct BoxCellEdit: View {
    
    let newBoxViewModel: NewBoxViewModel
    let action: () -> Void
    
    var body: some View {
        VStack(alignment: .center, spacing: 17) {
            ZStack{
            Image("new audiobox")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: WIDTH * 0.24, height: WIDTH * 0.24 * 1.52)
            Button() {
            //action
            } label: {
                Circle()
                .foregroundColor(Color(UIColor(red: 185/255, green: 26/255, blue: 24/255, alpha: 1)))
                .frame(width: WIDTH * 0.11, height: WIDTH * 0.11)
                .overlay (Image("Image"))
            }
            .offset(x: 40, y: 60)
            }
        
            Text(newBoxViewModel.newBox.title.isEmpty ? "Новый аудиобокс" : newBoxViewModel.newBox.title )
                .font(fontBold12)
                .foregroundColor(.customGray)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(width: WIDTH / 5, height: 42)
            HStack(spacing: 25){
                Button {
                   action()
                } label: {
                    Image("trash 1")
                }
                NavigationLink {
                    AudioEditView(viewModel: newBoxViewModel)
                } label: {
                    Image("edit 1")
                }
            }
            
        }
    }
}

//struct BoxCellEdit_Previews: PreviewProvider {
//    static var previews: some View {
//        BoxCellEdit()
//    }
//}
