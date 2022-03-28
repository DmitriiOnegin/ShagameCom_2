//
//  ArtCreatorViewModel.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 21.02.2022.
//

import Foundation

class ArtCreators: NSObject, ObservableObject {
    
    
    @Published var artCreators: [ArtCreator] = []
//    {
//        didSet {
//            // Saves the array 'items' to disc
//            do {
//                // find the documentDirectory and create an URL for the JSON file
//                let filename = getDocumentsDirectory().appendingPathComponent("artCreators.json")
//                let data = try JSONEncoder().encode(self.artCreators)
//                try data.write(to: filename, options: [.atomicWrite])
//            } catch {
//                print("Unable to save data.")
//            }
//        }
//    }
//    override init() {
//        // replaces a call to 'getDocumentsDirectory()' methode as it created an initialisation error.
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        // Add the first [0] path to the filename and create 'filename'
//        let filename = paths[0].appendingPathComponent("artCreators.json")
//        //print(filename)
//        do {
//            // Try to read the file (if it exist) and load the data into the array 'manyitem'
//            let data = try Data(contentsOf: filename)
//            artCreators = try JSONDecoder().decode([ArtCreator].self, from: data)
//            // Yes all good then exit
//            return
//        } catch {
//            // Something whent wrong. Initialize by creating an empty array 'manyitems'
//            self.artCreators = []
//            print("Unable to load saved data.")
//        }
//    }
//    // retreives the App's first DocumentDirectory
//    func getDocumentsDirectory() -> URL {
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        return paths[0]
//    }
    
}
