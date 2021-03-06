//
//  BoxMainScrollView.swift
//  ShagameCom
//
//  Created by Arslan Abdullaev on 21.02.2022.
//

import SwiftUI
import MapKit


struct Handle : View {
    let handleThickness = CGFloat(5.00)
    var body: some View {
        RoundedRectangle(cornerRadius: handleThickness / 2.0)
            .frame(width: 36, height: handleThickness)
            .foregroundColor(Color.gray)
            .padding(5)
    }
}

struct SlideOverCard<Content: View> : View {
    @Binding var showList: Bool
    @GestureState private var dragState = DragState.inactive
    @State var position = CardPosition.bottom
    @State var topPosition = CardPosition.top
//    var startPosition: CGFloat {
//        starterOffset()
//    }
    let animation = Animation.interpolatingSpring(stiffness: 300.0,
                                         damping: 30.0,
                                         initialVelocity: 10.0)
    var content: () -> Content
    var body: some View {
        let drag = DragGesture()
            .updating($dragState) { drag, state, transaction in
               
                state = .dragging(translation: drag.translation)
            }
            .onEnded(onDragEnded)
        
        return Group {
            
                VStack{
//                    Spacer()
                    ZStack{
                        Color.white.opacity(1.0)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        self.content()
                            .clipped()
                }
                    
            }
        }.offset(y: showList
                 ?
                
                 ((self.dragState.isDragging && dragState.translation.height >= 1) ?
             self.position.rawValue + dragState.translation.height : CardPosition.top.rawValue)
       
                 :
                   
             self.position.rawValue + self.dragState.translation.height
             
         )
//         .animation(self.dragState.isDragging
//                    ? nil
//                    : .interpolatingSpring(stiffness: 300.0,
//                                           damping: 30.0,
//                                           initialVelocity: 10.0))
       
         .gesture(drag)
    }
    
    private func onDragEnded(drag: DragGesture.Value) {
        let verticalDirection = drag.predictedEndLocation.y - drag.location.y
        let cardTopEdgeLocation = self.position.rawValue + drag.translation.height
        let positionAbove: CardPosition
        let positionBelow: CardPosition
        let closestPosition: CardPosition
        
        if cardTopEdgeLocation <= CardPosition.middle.rawValue {
            positionAbove = .top
            positionBelow = .middle
        } else {
            positionAbove = .middle
            positionBelow = .bottom
        }
        
        if (cardTopEdgeLocation - positionAbove.rawValue) < (positionBelow.rawValue - cardTopEdgeLocation) {
            closestPosition = positionAbove
        } else {
            closestPosition = positionBelow
        }
        
        if verticalDirection > 0 {
            self.position = positionBelow
        } else if verticalDirection < 0 {
            self.position = positionAbove
        } else {
            self.position = closestPosition
        }
        
        showList.toggle()
    }

}



enum CardPosition: CGFloat {
    case top = 190
    case middle = 400
    case bottom = 820
}

enum DragState {
    case inactive
    case dragging(translation: CGSize)
    
    var translation: CGSize {
        switch self {
        case .inactive:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }
    
    var isDragging: Bool {
        switch self {
        case .inactive:
            return false
        case .dragging:
            return true
        }
    }
}

struct MyPreviewProvider_Previews: PreviewProvider {
    static var previews: some View {
        SlideOverCard(showList: .constant(true)) {
            ScrollView{
                Text("mnnsfln")
                    .font(fontBold28)
               
                Text("mnnsfln")
                        .font(fontBold28)

                Text("mnnsfln")
                        .font(fontBold28)
                Text("mnnsfln")
                        .font(fontBold28)
                Text("mnnsfln")
                        .font(fontBold28)
                Text("mnnsfln")
                        .font(fontBold28)
                Text("mnnsfln")
                        .font(fontBold28)
                Text("mnnsfln")
                        .font(fontBold28)
                Text("mnnsfln")
                    .font(fontBold28)
               
                Text("mnnsfln")
                        .font(fontBold28)

            }.frame(maxHeight: 1500)
            }
        }
    }


//self.position.rawValue + self.dragState.translation.height
//(self.dragState.isDragging && dragState.translation.height >= 1) ? dragState.translation.height : CardPosition.top.rawValue
