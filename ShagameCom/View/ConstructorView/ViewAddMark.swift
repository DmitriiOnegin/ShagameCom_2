//
//  ViewAddMark.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 21.02.2022.
//

import MapKit
import SwiftUI
import CoreLocation

struct ViewAddMark: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = MapEditViewModel()
   
    @State private var showAlertItem = false
    
    @ObservedObject var newBoxViewModel: NewBoxViewModel

    var body: some View {
        ZStack {
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true, userTrackingMode: $viewModel.userTrackingMode, annotationItems: viewModel.locations + viewModel.marshrut
            ) { location in
                MapAnnotation(
                    coordinate: location.coordinate,
                    
                    anchorPoint: CGPoint(x: 0.5, y: 0.5)
                ) {
                    VStack{
                        
                        
                        if location.identifier == "epizod" {
                            
                            ZStack{
                                Image(systemName: "\(location.numberEpizod).circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50)
                                    .foregroundColor( Color.red)
                                    .scaleEffect(CGSize(width:  viewModel.scale,
                                                        height:  viewModel.scale), anchor: .center)
                                
                                //                                    Text("\(Int(location.timeStart))")
                                //                                        .font(.footnote)
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
                                    //                                        Text("\(Int(location.timeStart))")
                                    //                                            .font(.footnote)
                                    
                                }
                                
                            }
                        }
                        
                    }
                }
            }
            Button(action: {
                viewModel.locationsAppendMark(coordinate: viewModel.region)
                
                viewModel.createMarshrut(tipe: "point")
            }) {
                Image("shg_map2")
            }
            .offset(x: 0, y: -50)
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        viewModel.showMyLocation()
                    }) {
                        Image(systemName: "location")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 32)
                    }
                    .padding()
                    .background(Color.red).opacity(0.7)
                    .foregroundColor(.white)
                    .frame(width: 60)
                    .clipShape(Circle())
                    .padding(20)
                }
                Spacer()
                if !viewModel.locations.isEmpty {
                    VStack {
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                
                                viewModel.dellLastPointLocations()
                                viewModel.createMarshrut(tipe: "point")
                                showAlertItem.toggle()
                                
                                viewModel.createTimeMarshrut()
                            }) {
                                Image(systemName: "arrow.uturn.left")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 40)
                            }
                            .padding()
                            .background(Color.red.opacity(0.7))
                            .foregroundColor(.white)
                            .frame(width: 60)
                            .clipShape(Circle())
                            .padding(.horizontal, 20)
                            
                        }
                    }
                }
                
                Spacer()
                
                Button(action: {
                   
                    newBoxViewModel.addLocationData(locations: viewModel.locations)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: 214, height: 34)
                        .foregroundColor(.red)
                        .overlay(
                            Text("Добавить маршрут")
                                .font(fontMedium12)
                                .foregroundColor(.white)
                        )
                }
                Button(action: {
                   
                    viewModel.locations = newBoxViewModel.newBox.conditionLocation
                    viewModel.createMarshrut(tipe: "point")
                    if  viewModel.locations.count > 0 {
                        viewModel.region.center = viewModel.locations[0].coordinate
                    }
                }) {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: 214, height: 34)
                        .foregroundColor(.red)
                        .overlay(
                            Text("Открыть маршрут")
                                .font(fontMedium12)
                                .foregroundColor(.white)
                        )
                }
               // Spacer(minLength: 20)
            }
            Spacer(minLength: 100)
        }
        .ignoresSafeArea()
        .onAppear(perform: {
            viewModel.locations = newBoxViewModel.newBox.conditionLocation
            viewModel.createMarshrut(tipe: "point")

            if  viewModel.locations.count > 0 {
                viewModel.region.center = viewModel.locations[0].coordinate
            }
        })
//        .onDisappear(perform: {
//            newBoxViewModel.newBox.conditionLocation = viewModel.locations
//        })

    }
}


