//
//  BoxPlayerView.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 14.02.2022.
//

import SwiftUI
import MapKit

struct BoxPlayerView: View {
    
    let box: Box
    @ObservedObject var viewModel: BoxPlayerViewModel
   
    @State private var didSave = false
    @State private var didFetchAudio = false
    @State private var play = false
    
    init(box: Box) {
        self.box = box
        self.viewModel = BoxPlayerViewModel(box: box)
    }
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var navigationViewModel: NavigationViewModel
   
    @State private var showMainMenu = false
    
    @State private var showList: Bool = false
    @State private var showBoxes: Bool = false
    
    var body: some View {
        ZStack{
            VStack(spacing: 0) {
                HeadLittle(title: viewModel.box.title)
                
                Map(coordinateRegion: $viewModel.region, showsUserLocation: true, userTrackingMode: .constant(viewModel.userTrackingMode), annotationItems:
                        [viewModel.box]
                  
                ) { boxViewModel in
                    MapAnnotation(
                        coordinate:
                            box.conditionLocationCL?.first ?? coordinateCentrMap,
                        anchorPoint: CGPoint(x: 0.5, y: 0.7)
                    ) {
                        Button {
                            
                            
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
            
            
            VStack{
                Spacer()
                ZStack{
                    Rectangle()
                        .fill(Color.white)
                        .cornerRadius(15, corners: [.topLeft,.topRight])
                    VStack(spacing: 30){
                        HStack{
                            Text("00.45")
                            Rectangle()
                                .fill(Color.sh_basicGrey)
                                .frame(height: 30)
                                .overlay(
                                    Button {
                                        viewModel.saveAudioBox(uid: box.ownerUid) { result in
                                            switch result {
                                            case .success():
                                                viewModel.setAudioSession()
                                                didSave = true
                                            case .failure(_):
                                                do {}
                                            }
                                        }
                                    } label: {
                                        Text("Загрузка и установка сессии")
                                    }
                                )
                            Text("-2.03")
                        }
                        .padding(.horizontal)
                        Text(viewModel.box.title)
                            .foregroundColor(.sh_basicGrey)
                            .font(fontLight24)
                        if didSave {
                            Button {
                                viewModel.play()
                            } label: {
                                Image(viewModel.isPlaying ? "pause" : "play")
                            }
                        } else {
                            ProgressView()
                        }
                        
                    }
                    .padding()
                }
                .frame(width: WIDTH, height: HEIGHT / 2.85 / cooficient)
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


    
