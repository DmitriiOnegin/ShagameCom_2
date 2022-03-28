//
//  NewBoxViewModel.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 03.02.2022.
//

import UIKit

class NewBoxViewModel: ObservableObject, Identifiable {
    
    let id = UUID()
    @Published var newBox: NewBox
    {
        didSet {
          //  savesNewBox()
            NewBoxesViewModel.shared.savesAllNewBoxes()
            NewBoxesViewModel.shared.upData.toggle()
        }
    }
    
    
    init(newBox: NewBox) {
        self.newBox = newBox
        
       // fetchNewBox()
    }
    
//    private func checkNewBox(){
//
//        //  загрузка из памяти телефона фото и аудио ранее добавленных в проект
//    }
    
    private func fetchNewBox(){
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let filename = paths[0].appendingPathComponent("NewBox" + "\(newBox.id)" + ".json")
        do {
            let data = try Data(contentsOf: filename)
            newBox = try JSONDecoder().decode(NewBox.self, from: data)
            return
        } catch {
            
            print("Unable to load saved data from NewBox" + "\(newBox.id)" + ".json.")
        }
    }
    
    private func savesNewBox(){
        do {
            let filename = Documents_Directory.appendingPathComponent("NewBox" + "\(newBox.id)" + ".json")
            let data = try JSONEncoder().encode(newBox)
            try data.write(to: filename, options: [.atomicWrite])
        } catch {
            print("Unable to save data to NewBox" + "\(newBox.id)" + ".json.")
        }
    }
    
    func addAudioData() {
        // add Completion Result
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "otbivka", ofType: "mp3")!)
        do {
            let audioData = try Data(contentsOf: url)
            newBox.audioData = audioData
            return
        } catch {
            print("Unable to load saved audioData.")
        }
    }
    
    func addImageData() {
        // add Completion Result
        let image = UIImage(named: "TestImage")
        guard let imageData = image?.jpegData(compressionQuality: 0.5) else { return }
        newBox.imageData = imageData
    }
    
    func addLocationData(locations: [Mark]) {
        newBox.conditionLocation = locations
    }
    
    func uploadBox(completion: @escaping () -> Void) {
        NetworkManager.shared.uploadBox(newBox: newBox) { result in
            switch result {
               
            case .success(_):
                BoxesViewModel.shared.fetchAllBoxes()
                completion()
            case .failure(_):
                do {}
            }
        }
    }
    
}


