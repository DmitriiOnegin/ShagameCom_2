//
//  BoxPlayerViewModel.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 14.02.2022.
//

//import Foundation
//import AVKit
//import MediaPlayer
import AVFoundation

class BoxPlayerViewModel: ObservableObject {
    
    let box: Box
    var player: AVAudioPlayer!
    var isPlaying = false
    
    private let audioSession = AVAudioSession.sharedInstance()
    
    init(box: Box) {
        self.box = box
        
       
    }
    
    func setAudioSession() {
        
        self.fetchAudioBox() { audioData in
           
                do {
                    
                    self.player = try AVAudioPlayer(data: audioData)
                    try self.audioSession.setCategory(.playback, mode: .moviePlayback, options: [])
                    try self.audioSession.setActive(true)
                    self.player.prepareToPlay()
                    
                } catch let error {
                    print("Unable to save data.", error.localizedDescription)
                }
            }
        
       // player.prepareToPlay()
    }
    
    
    func play() {
        if player.isPlaying{player.pause()}
        else {player.play()}
        isPlaying = player.isPlaying
    }
    
    func saveAudioBox(uid: String, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        
        NetworkManager.shared.loadAudio(uid: uid) { result in
            switch result {
            case .success(let audioData):
                do {
                    let filename = Documents_Directory.appendingPathComponent("audio_\(uid)")
                    let data = audioData
                    try data.write(to: filename)
                } catch let error {
                    print("Unable to save data.", error.localizedDescription)
                }
                completion(.success(Void()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchAudioBox(completion: @escaping (Data) -> Void) {
        
        do {
            let filename = Documents_Directory.appendingPathComponent("audio_\(String(describing: box.ownerUid))")
            let audioData = try Data(contentsOf: filename)
            DispatchQueue.main.async {
                completion(audioData)
            }
            return
        } catch let error {
            print("Unable to load saved data.", error.localizedDescription)
        }
    }
    
}



    
    
    

