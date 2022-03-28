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
//        ScrollView(.horizontal, showsIndicators: false) {
//            LazyHStack(spacing: 20) {
//                Button {
//                    viewModel.addNewBox()
//                } label: {
//                    NewBoxCell()
//                }
//
//                ForEach (viewModel.allNewBoxes.reversed()){ newBoxViewModel  in
//
//                    VStack(alignment: .center, spacing: 17) {
//                        Image("new audiobox")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: WIDTH / 5)
//                        Text(newBoxViewModel.newBox.title.isEmpty ? "Новый аудиобокс" : newBoxViewModel.newBox.title )
//                            .font(fontBold12)
//                            .multilineTextAlignment(.center)
//                            .lineLimit(2)
//                            .frame(width: WIDTH / 5)
//                        HStack{
//                            Button {
//                                viewModel.removeNewBox(selectedBox: newBoxViewModel)
//                            } label: {
//                                Image("trash 1")
//                            }
//                            NavigationLink {
//                                AudioEditView(viewModel: newBoxViewModel)
//                            } label: {
//                                Image("edit 1")
//                            }
//                        }
//
//                    }
//                }
//
//                ForEach (ownBoxes){ boxViewModel  in
//                    NavigationLink {
//                        BoxPlayerView(box: boxViewModel.box)
//                    } label: {
//                        BoxCellOwnProfile(box: boxViewModel.box)
//                    }
//                }
//            }
//        }
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
                        BoxPlayerView(box: boxViewModel.box)
                    } label: {
                        BoxCellOwnProfile(box: boxViewModel.box)
                    }
                }
            }
        .padding()
        }
    }
}

//struct OwnAllBoxes_Previews: PreviewProvider {
//    static var previews: some View {
//        OwnAllBoxes()
//    }
//}
