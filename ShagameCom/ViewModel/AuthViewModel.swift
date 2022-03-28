//
//  AuthViewModel.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 03.02.2022.
//

import Foundation
import Firebase
//import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    static let shared = AuthViewModel()
    
    private init() {
        self.userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: error login: \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            self.fetchUser()
            
        }
        print("login")
    }
    
    func register(withEmail email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: error register: \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            
            print("Successfully registreted user...")
            
            let data = ["email" : email,
                        "fullName" : "",
                        "town" : "",
                        "profileImageUrl" : "",
                        "uid" : user.uid,
                        "work" : ""
            ]
            
            COLLECTION_USERS.document(user.uid).setData(data) { _ in
                print("Successfully uploaded user data...")
                self.userSession = user
                self.fetchUser()
            }
            
        }
        
    }
    
    func signout() {
        
        self.userSession = nil
        try? Auth.auth().signOut()
        print("signout")
    }
    
    func fetchUser() {
        guard let uid = userSession?.uid else { return }
        
        COLLECTION_USERS.document(uid).getDocument { snapshot, _ in
            guard let user = try? snapshot?.data(as: User.self) else { return }
            self.currentUser = user
            print("DEBUG: user is: \(user)")
        }
        print("fetchUser")
    }
}
