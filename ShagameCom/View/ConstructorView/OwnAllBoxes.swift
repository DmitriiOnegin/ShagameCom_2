//
//  OwnAllBoxes.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 18.02.2022.
//

import SwiftUI

struct OwnAllBoxes: View {
    
    let ownBoxes: [BoxViewModel]
    @ObservedObject var viewModel = NewBoxesViewModel.shared
    
    var body: some View {

        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 30) {
                Button {
                    viewModel.addNewBox()
                } label: {
                    NewBoxCell()
                }
                
                ForEach (viewModel.allNewBoxes.reversed()){ newBoxViewModel  in
                    
                    BoxCellEdit(newBoxViewModel: newBoxViewModel) {
                        viewModel.removeNewBox(selectedBox: newBoxViewModel)
                    }
                }

                ForEach (ownBoxes){ boxViewModel  in
                    NavigationLink {
                        BoxAboutView(viewModel: boxViewModel)
                    } label: {
                        BoxCellOwnProfile(box: boxViewModel.box)
                    }
                }
            }
        .padding()
        }
    }
}
