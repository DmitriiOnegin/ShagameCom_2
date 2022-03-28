//
//  NetworkManager.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 03.02.2022.
//

import Foundation
import Firebase
import CoreLocation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case uploadImageError
    case uploadAudioError
    case fetchError
    case uploadError
}

enum UploadType {
    case profile
    case boxImage
    case boxAudio
    
    var filePath: StorageReference {
       
        switch self {
        case .profile:
            return Storage.storage().reference(withPath: "/profile_Images/")
        case .boxImage:
            return Storage.storage().reference(withPath: "/letter_Images/")
        case .boxAudio:
            return Storage.storage().reference(withPath: "/letter_Audio/")
        }
    }
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    private func uploadImage(imageData: Data?, type: UploadType, uid: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        
        guard let imageData = imageData else { return }
        let ref = type.filePath.child(uid)
        
        ref.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print("DEBUG: uploadImage error: \(error.localizedDescription)")
                completion(.failure(.uploadImageError))
                return
            }
            
            print("Successfully uploaded image...")
            
            ref.downloadURL { url, _ in
                guard let imageUrl = url?.absoluteString else { return }
                completion(.success(imageUrl))
            }
        }
    }
    
    private func uploadAudio(audio: Data?, type: UploadType, uid: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        
        guard let audioData = audio else { return }
        let ref = type.filePath.child(uid)
        
        ref.putData(audioData, metadata: nil) { _, error in
            if let error = error {
                print("DEBUG: uploadAudio error: \(error.localizedDescription)")
                completion(.failure(.uploadAudioError))
                return
            }
            
            print("Successfully uploaded audio...")
            
            ref.downloadURL { url, _ in
                guard let audioUrl = url?.absoluteString else { return }
                completion(.success(audioUrl))
            }
        }
    }
    
    
    
    private func translateCoordinate(marks: [Mark]) -> [GeoPoint] {

        return marks.map{ GeoPoint(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude)}
    }
    
    func editUserImage(imageData: Data, completion: @escaping (Result<Void, NetworkError>) -> Void){
        
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        
        uploadImage(imageData: imageData, type: .profile, uid: currentUid) { result in
            switch result {
            case .success(let imageUrl):
                
                COLLECTION_USERS.document(currentUid).updateData(["profileImageUrl" : imageUrl]) { _ in
                    AuthViewModel.shared.fetchUser()
                    completion(.success(Void()))
                }
            case .failure(let error):
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
    }
    
    func editUserData(fullName: String, town: String, work: String, completion: @escaping (Result<User, NetworkError>) -> Void){
        
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        
        COLLECTION_USERS.document(uid).updateData(["fullName" : fullName,
                                                   "town" : town,
                                                   "work" : work]) { error in
            if let error = error {
                print("DEBUG: uploadUserData error: \(error.localizedDescription)")
                completion(.failure(.uploadError))
                return
            }
            
            //AuthViewModel.shared.fetchUser()
            COLLECTION_USERS.document(uid).getDocument { snapshot, error in
                if error != nil {
                    completion(.failure(.fetchError))
                    return
                }
                
                guard let user = try? snapshot?.data(as: User.self) else { return }
                completion(.success(user))
                print("DEBUG: user is: \(user)")
            }
//            completion(.success(Void()))
        }
    }
    
    func uploadBox(newBox: NewBox, complition: @escaping (Result<Void, NetworkError>) -> Void) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        
        uploadImage(imageData: newBox.imageData, type: .boxImage, uid: currentUid) { result in
            switch result {
            case .success(let imageUrl):
                
                self.uploadAudio(audio: newBox.audioData, type: .boxAudio, uid: currentUid) { result in
                    switch result {
                    case .success(let audioUrl):
                        
                        let conditionLocation = self.translateCoordinate(marks: newBox.conditionLocation)
                        
                        let data = [ "title": newBox.title,
                                     "description": newBox.description,
                                     "timestamp": Timestamp(date: Date()),
                                     "imageUrl": imageUrl,
                                     "audioUrl": audioUrl,
                                     "ownerUid": currentUid,
                                     "ownerFullName": user.fullName,
                                     "oldCondition": newBox.oldCondition,
                                     "conditionLocation": conditionLocation,
                                     "totalRating": [0, 0],
                                     "totalViews": 0,
                                     "totalSteps": newBox.totalSteps,
                                     "totalTime": newBox.totalTime
                        ] as [String : Any]
                        
                      
                        COLLECTION_USERS.document(currentUid).collection("boxes").addDocument(data: data){ _ in
                           
                            switch result {
                            case .success(_):
                                complition(.success(Void()))
                            case .failure(let error):
                                complition(.failure(error))
                                print(error.localizedDescription)
                            }
                        }
                    case .failure(let error):
                        complition(.failure(error))
                        print(error.localizedDescription)
                    }
                }
            case .failure(let error):
                complition(.failure(error))
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchAllBoxes(complition: @escaping (Result<[Box], NetworkError>) -> Void) {
        var allBoxes = [Box]()
        var filterBoxes = [Box]()
        var stopListUsersUid = [String]()
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
      
        COLLECTION_STOPUSERSLIST.document(currentUid).collection("stopUsersList").getDocuments { snapshot, _ in
        
            guard let documents = snapshot?.documents else {
                complition(.failure(.fetchError))
                return
            }
            
            for document in documents {
                stopListUsersUid.append(document.documentID)
            }
            
            Firestore.firestore().collectionGroup("boxes").getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else {
                    complition(.failure(.fetchError))
                    return
                }
                allBoxes = documents.compactMap({ try? $0.data(as: Box.self)}).sorted(by: {
                    $0.timestamp.dateValue() > $1.timestamp.dateValue()
                })
                allBoxes.forEach { box in
                    if !stopListUsersUid.contains(box.ownerUid){
                        filterBoxes.append(box)
                    }
                }
                complition(.success(filterBoxes))
            }
        }
    }
    
    func fetchUidIsFavoritBoxes(complition: @escaping (Result<[String], NetworkError>) -> Void) {

        guard let uid = AuthViewModel.shared.userSession?.uid else { return }

            COLLECTION_USERS.document(uid).collection("user-favorits").getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else {
                    complition(.failure(.fetchError))
                    return
                }
                let boxesUid = documents.compactMap({$0.documentID})

                complition(.success(boxesUid))
            }
    }

    func fetchUidDidOpenBoxes(complition: @escaping (Result<[String], NetworkError>) -> Void) {

        guard let uid = AuthViewModel.shared.userSession?.uid else { return }

            COLLECTION_USERS.document(uid).collection("user-OpenBoxes").getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else {
                    complition(.failure(.fetchError))
                    return
                }
                let boxesUid = documents.compactMap({$0.documentID})

                complition(.success(boxesUid))
            }
    }
    
    func checkIfUserDidOpenBox(box: Box, complition: @escaping (Result<Bool, NetworkError>) -> Void) {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        guard let boxUid = box.id else { return }
        
        COLLECTION_USERS.document(uid).collection("user-OpenBoxes").document(boxUid).getDocument { snapshot, _ in
            guard let didOpen = snapshot?.exists else {
                complition(.failure(.fetchError))
                return }
            complition(.success(didOpen))
        }
    }
    
    func checkIfUserIsFavoritBox(box: Box, complition: @escaping (Result<Bool, NetworkError>) -> Void) {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        guard let boxUid = box.id else { return }
        
        COLLECTION_USERS.document(uid).collection("user-favorits").document(boxUid).getDocument { snapshot, _ in
            guard let didFavorit = snapshot?.exists else {
                complition(.failure(.fetchError))
                return }
            complition(.success(didFavorit))
        }
    }
    
    func didFavoritBox(box: Box, complition: @escaping (Result<Bool, NetworkError>) -> Void) {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        guard let boxUid = box.id else { return }
        
        COLLECTION_USERS.document(uid).collection("user-favorits").document(boxUid).setData([:]) { error in
            if error != nil {
                complition(.failure(.uploadError))
                return
            }
            complition(.success(true))
            print("DEBUG: The box set is Favorit")
        }
    }
    
    func didUnfavoritBox(box: Box, complition: @escaping (Result<Bool, NetworkError>) -> Void) {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        guard let boxUid = box.id else { return }
        
        COLLECTION_USERS.document(uid).collection("user-favorits").document(boxUid).delete { error in
            if error != nil {
                complition(.failure(.uploadError))
                return
            }
            complition(.success(false))
            print("DEBUG: The box NOT is Favorit")
        }
    }
    
    func didOpenBox(box: Box, complition: @escaping (Result<Bool, NetworkError>) -> Void) {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        guard let boxUid = box.id else { return }
        
        let newTotalViews = box.totalViews + 1
        
        COLLECTION_USERS.document(uid).collection("user-OpenBoxes").document(boxUid).setData([:]) { error in
            if error != nil {
                complition(.failure(.uploadError))
                return
            }
            
            COLLECTION_USERS.document(box.ownerUid).collection("boxes").document(boxUid).updateData(["totalViews": newTotalViews]) { error in
                if error != nil {
                    complition(.failure(.uploadError))
                    return
                }
                complition(.success(true))
            }
        }
    }
    
   func fetchUser(user: User, complition: @escaping (Result<User, NetworkError>) -> Void) {
        guard let uid = user.id else { return }
        
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            if error != nil {
                complition(.failure(.fetchError))
                return
            }
            
            guard let user = try? snapshot?.data(as: User.self) else { return }
            complition(.success(user))
            print("DEBUG: user is: \(user)")
        }
        print("fetchUser")
    }
    
    func loadAudio(uid: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        
        let type = UploadType.boxAudio
        let ref = type.filePath.child(uid)
        print(ref)
        ref.getData(maxSize: 10000000000000) { snapshot, error in
            if error != nil {
                completion(.failure(.fetchError))
                print(ref)
                return
            }
            
            guard let audioData = snapshot else { return }
            completion(.success(audioData))
        }
    }
    
    func editBoxData(box: Box, completion: @escaping (Result<Bool, NetworkError>) -> Void){
        
        let uid = box.ownerUid
        guard let uidBox = box.id else { return }
        
        COLLECTION_USERS.document(uid).collection("boxes").document(uidBox).updateData(
            ["totalRating": box.totalRating,
             "totalViews": box.totalViews]) { error in
                 if let error = error {
                     print("DEBUG: uploadUserData error: \(error.localizedDescription)")
                     completion(.failure(.uploadError))
                     return
                 }
                 
//                 COLLECTION_USERS.document(uid).collection("boxes").document(uidBox).getDocument { snapshot, error in
//                     if error != nil {
//                         completion(.failure(.fetchError))
//                         return
//                     }
//
//                     guard let box = try? snapshot?.data(as: Box.self) else { return }
//                     completion(.success(box))
//                     print("DEBUG: user is: \(box)")
//                 }
                 completion(.success(true))
                 print("DEBUG: editBoxData is: \(true)")
             }
    }
    
    
    
    
    
//    func addUserToStopList(uid: String, completion: ((Error?) -> Void)?) {
//        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
//
//        COLLECTION_STOPUSERSLIST.document(currentUid).collection("stopUsersList")
//            .document(uid).setData([:], completion: completion)
//    }
//
//    func пожаловаться
    
}
