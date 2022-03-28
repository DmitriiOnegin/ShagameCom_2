//
//  RigisterForListenView.swift
//  ShagameCom
//
//  Created by Arslan Abdullaev on 12.03.2022.
//

import SwiftUI

struct NotificationView: View {
    let text: String
    let firstButtonImage: String
    let secondButtonImage: String?
    
    init(text: String, firstButtonImage: String, secondButtonImage: String? ) {
        self.text = text
        self.firstButtonImage = firstButtonImage
        self.secondButtonImage = secondButtonImage
    }
    
    var body: some View {
        VStack{
            Spacer()

            
            
            VStack(alignment: .center){
                VStack(alignment: .center, spacing: 20){
                Image("attention")
                Text(text)
                    .multilineTextAlignment(.center)
                    .font(fontRegular16)
                }.padding(.horizontal, 25)
                    .padding(.top, 20)

            HStack{
                    Button(action: {}, label: {
                        Image(firstButtonImage)
                    })
                        .padding(.top, 9)
                
                if secondButtonImage != nil {
                    Button(action: {}, label: {
                        Image(secondButtonImage!)
                    })
                }
            }.padding(.bottom, 10)
        }
            .padding(.top, 15)
            .background(Color.white
            .cornerRadius(12))
            .frame(width: WIDTH * 0.78)
            Spacer()
        }
    }
}

struct RigisterForListenView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.yellow
                .ignoresSafeArea()
            NotificationView(
                              text: Notification.claimOk.notice.text,
                              firstButtonImage: Notification.claimOk.notice.firstButtonImage,
                              secondButtonImage: Notification.claimOk.notice.secondButtonImage)
            }
    }
}
