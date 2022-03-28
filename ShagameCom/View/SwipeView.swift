//
//  SlideOverCard2.swift
//  ShagameCom
//
//  Created by Arslan Abdullaev on 21.03.2022.
//

import SwiftUI

struct SwipeView<Content: View> : View{
    @State var height: CGFloat = HEIGHT * 0.09
    @State var text: String = "ПОКАЗАТЬ СПИСОК"
    @State var isShow: Bool = true
    let handleThickness = CGFloat(5.00)
    var minHeight: CGFloat { HEIGHT * 0.1 }
    var maxHeight: CGFloat { HEIGHT * 0.75 }
    
    var content: () -> Content
    var body: some View{
        
        VStack{
            VStack{
                RoundedRectangle(cornerRadius: handleThickness / 2.0)
                    .frame(width: 36, height: handleThickness)
                    .foregroundColor(Color.gray)
                    .padding(.top, 15)
                if isShow{
                Text(text)
                        .font(fontMedium16)
                        .foregroundColor(.customRed)
                        .padding(.top, 10)
                        .padding(.bottom, 20)
                }
                self.content()
                    .clipped()
                
                
            }.frame(height: height, alignment: .top)
                .frame(maxWidth: .infinity)
                .background(Rectangle()
                                .fill(Color.white)
                                .cornerRadius(15, corners: [.topLeft,.topRight])
                                .gesture(dragGesture)
                )
            
                
        }
    }
    
    var dragGesture: some Gesture{
        DragGesture(minimumDistance: 0)
            .onChanged { val in
                var newHeight = height - val.translation.height
            
                if newHeight > maxHeight {
                    newHeight = maxHeight - val.translation.height / 2
                }
                else if newHeight < minHeight {
                    newHeight = minHeight
                    
                }
                height = newHeight
                
            }
            .onEnded { val in
                let precentage = height / maxHeight
                var finalHeight = maxHeight
                
                if precentage < 0.45 {
                    finalHeight = minHeight
                }
                
                withAnimation(Animation.easeInOut(duration: 0.3)) {
                    height = finalHeight
                }
                
                if height == minHeight {
                    isShow = true
                } else {
                    isShow = false
                }
            }
    }
}

//struct SlideOverCard2_Previews: PreviewProvider {
//    static var previews: some View {
//
//            
//            ZStack(alignment: .bottom){
//            Color.red.ignoresSafeArea()
//           
//            SwipeView{
//                ScrollView{
//                    Text("hello World")
//                    
//                }
//            }
//        }
//    }
//}
