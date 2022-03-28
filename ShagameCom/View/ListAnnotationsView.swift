//
//  ListAnnotationsView.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 21.02.2022.
//

import SwiftUI

struct ListAnnotationsView: View {
    
    @ObservedObject var viewModel: AudiotekaViewModel
    
    @Binding var showCellAnotationView: Bool
    @Binding var showList: Bool
    @Binding var getBox: BoxViewModel?
   
    var body: some View {
        VStack{
            RoundedRectangle(cornerRadius: 5)
                .frame(width: WIDTH / 7, height: 5)
                .foregroundColor(.white)
                .padding(.vertical)
        
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(viewModel.filterBoxes) { boxViewModel in
//                    Button {
//                        showCellAnotationView.toggle()
//                        showList = false
//                        getBox = boxViewModel
//                    } label: {
                        BoxCellMap(viewModel: boxViewModel)
                        
                   // }
                }
                Spacer(minLength: 200 * cooficient)
            }
        }
    }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(.black)
                .opacity(0.8)
        )
    }
}


