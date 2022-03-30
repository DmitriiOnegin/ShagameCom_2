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
    let typePleerView: TypePleerView
    @ObservedObject var viewModel: BoxPlayerViewModel
   
    @State private var didSave = false
    @State private var didFetchAudio = false
    @State private var play = false
    
    init(box: Box, typePleerView: TypePleerView) {
        self.box = box
        self.typePleerView = typePleerView
        self.viewModel = BoxPlayerViewModel(box: box, typePleerView: typePleerView)
    }
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var navigationViewModel: NavigationViewModel
   
    @State private var showMainMenu = false
    
    
   // @State private var typePleerView: TypePleerView = .map
    
    var body: some View {
        ZStack{
            VStack(spacing: 0) {
                HeadLittle(title: viewModel.box.title)
                
                Map(coordinateRegion: $viewModel.region, showsUserLocation: true, userTrackingMode: .constant(viewModel.userTrackingMode), annotationItems:
                        viewModel.locations + viewModel.marshrut
                  
                ) { location in
                    MapAnnotation(
                        coordinate:
                            location.coordinate ,
                        anchorPoint: CGPoint(x: 0.5, y: 0.7)
                    ) {
                        if location.identifier == "epizod" {
                            if location.number == 1 {
                                AnnotationView(region: $viewModel.region)
                            } else {
                            ZStack{
                                Image(systemName: "circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50)
                                    .foregroundColor( Color.red)
                                    .scaleEffect(CGSize(width:  viewModel.scale,
                                                        height:  viewModel.scale), anchor: .center)
                            }
                            }
                        }
                        
                        else {
                            if location.identifier == "marshrut" {
                                
                                ZStack{
                                    Image(systemName: "circle.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 25)
                                        .foregroundColor(.red)
                                        .scaleEffect(CGSize(width:  viewModel.scale2,
                                                            height:  viewModel.scale2), anchor: .center)
                                    
                                }
                                
                            }
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
                    switch viewModel.type {
                    case .player:
                    
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
                        Button {
                            viewModel.type = .rating
                        } label: {
                        Text(viewModel.box.title)
                            .foregroundColor(.sh_basicGrey)
                            .font(fontLight24)
                        }
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
                        
                    case .map:
                        VStack(spacing: 30){
                            Button {
                                viewModel.type = .player
                            } label: {
                                Image("btn - CangeTypeToPlayer")
                            }

                        }
                    case .rating:
                        VStack(spacing: 30){
                            Button {
                                viewModel.type = .player
                            } label: {
                                Image("btn - setRating")
                            }

                        }
                    }
                }
                .frame(width: WIDTH, height: viewModel.type == .map ? HEIGHT / 6.1 / cooficient : HEIGHT / 2.85 / cooficient)
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


enum TypePleerView {
    case map
    case player
    case rating
}
