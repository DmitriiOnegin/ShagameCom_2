//
//  NewBoxesViewModel.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 12.02.2022.
//

import Foundation

class NewBoxesViewModel: ObservableObject {
    
 //   @Published var allNewBoxes = [NewBoxViewModel]()
//    {
//        didSet {
//            savesAllNewBoxes()
//        }
//    }
    
//    init() {
//       // fetchAllNewBoxes()
//        print("init NewBoxesViewModel")
//    }
    
   static let shared = NewBoxesViewModel()
    
    @Published var allNewBoxes = [NewBoxViewModel]()
    @Published var upData = false
    
   private init() {
       fetchAllNewBoxes()
       print("init NewBoxesViewModel")
    }
    
    func fetchAllNewBoxes(){
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let filename = paths[0].appendingPathComponent("AllNewBoxes.json")
        do {
            let data = try Data(contentsOf: filename)
            let newBoxes = try JSONDecoder().decode([NewBox].self, from: data)
            allNewBoxes = newBoxes.map{NewBoxViewModel(newBox: $0)}
            return
        } catch {
            allNewBoxes = []
            print("Unable to load saved data from AllNewBoxes.json.")
        }
    }
    
    func savesAllNewBoxes(){
        do {
            let filename = Documents_Directory.appendingPathComponent("AllNewBoxes.json")
            let newBoxes = allNewBoxes.map{$0.newBox}
            let data = try JSONEncoder().encode(newBoxes)
            try data.write(to: filename, options: [.atomicWrite])
            print("savesAllNewBoxes to AllNewBoxes.json.")
        } catch {
            print("Unable to save data to AllNewBoxes.json.")
        }
    }
    
    func addNewBox(){
        let newBoxViewModel = NewBoxViewModel(newBox: NewBox.getNewBox())
        allNewBoxes.append(newBoxViewModel)
        savesAllNewBoxes()
    }
    
    func removeNewBox(selectedBox: NewBoxViewModel){
        if let index = allNewBoxes.firstIndex(where: { $0.id == selectedBox.id}) {
            allNewBoxes.remove(at: index)
            savesAllNewBoxes()
        }
    }
    
}



