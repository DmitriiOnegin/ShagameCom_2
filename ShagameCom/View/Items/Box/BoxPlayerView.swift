//
//  BoxPlayerView.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 14.02.2022.
//

import SwiftUI

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
    
    var body: some View {
        VStack (spacing: 20){
            Button {
                viewModel.saveAudioBox(uid: box.ownerUid) { result in
                    switch result {
                    case .success():
                        didSave = true
                    case .failure(_):
                        do {}
                    }
                }
            } label: {
                Text(didSave ? "Данные загружены" : "Нет данных")
            }
            
            Button {
                viewModel.setAudioSession()
            } label: {
                Text("setAudioSession")
            }
            
            Button {
                viewModel.play()
            } label: {
                Text(viewModel.isPlaying ? "Stop" : "Play")
            }

        }
    }
}

