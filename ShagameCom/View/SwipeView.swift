//
//  SlideOverCard2.swift
//  ShagameCom
//
//  Created by Arslan Abdullaev on 21.03.2022.
//

import SwiftUI

struct SlideOverCard2: View {
    
    var body: some View {
        VStack{
//            Spacer()
//        SwipeView()
        }.frame(maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .bottom)
            .ignoresSafeArea(edges: .bottom)
    }
}

struct SwipeView<Content: View> : View{
    @State var height: CGFloat = 90
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
                    .padding(5)
                Text("ПОКАЗАТЬ СПИСОК")
                    .font(fontMedium16)
                    .foregroundColor(.customRed)
                
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
