//
//  AudiotekaView.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 06.02.2022.
//

import SwiftUI
import MapKit

struct AudiotekaView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    
    @ObservedObject var viewModel: AudiotekaViewModel
    
    @State private var showMainMenu = false
    
    @State private var showCellAnotationView: Bool = false
    @State private var showList: Bool = false
    @State private var showBoxes: Bool = false
    
    @State private var getBox: BoxViewModel?
    
    init(allBoxes: [BoxViewModel]) {
       
        self.viewModel = AudiotekaViewModel(allBoxes: allBoxes)
    }
    //----
    @State var height: CGFloat = 90
    let handleThickness = CGFloat(5.00)
    var minHeight: CGFloat { HEIGHT * 0.1 }
    var maxHeight: CGFloat { HEIGHT * 0.75 }
    //----
    
    var body: some View {
        ZStack{
            VStack(spacing: 0) {
                HeadLittle(title: "Аудиотека")
                
                Map(coordinateRegion: $viewModel.region, showsUserLocation: true, userTrackingMode: .constant(viewModel.userTrackingMode), annotationItems:
                        viewModel.filterBoxes
                  
                ) { boxViewModel in
                    MapAnnotation(
                        coordinate:
                            boxViewModel.box.conditionLocationCL?.first ?? coordinateCentrMap,
                        anchorPoint: CGPoint(x: 0.5, y: 0.7)
                    ) {
                        Button {
                            
                            showCellAnotationView.toggle()
                            showList = false
                            getBox = boxViewModel
                        } label: {
                            AnnotationView(region: $viewModel.region)
                        
                        }
                    }
                }
                
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
                Spacer()
            }
            
            if let boxViewModel = getBox, showCellAnotationView  {
                ZStack{
                    Color.white.opacity(0.001)
                        .onTapGesture {
                            showCellAnotationView = false
                        }
                    VStack{
                        Spacer()
                        BoxCellMap(viewModel: boxViewModel)
                        Spacer()
                    }
                }
                
            }
            
            VStack{
                Spacer()
                SwipeView{
                    ScrollView(showsIndicators: false) {
                        LazyVStack(alignment: .leading) {
                            ForEach(viewModel.filterBoxes) { boxViewModel in
                                BoxCellMap(viewModel: boxViewModel)
                            }
                        }
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
        }.ignoresSafeArea()
        
    }
}

