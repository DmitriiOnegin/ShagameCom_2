//
//  Constants.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 31.01.2022.
//

import SwiftUI
import Firebase
import CoreLocation

let WIDTH = UIScreen.main.bounds.width
let HEIGHT = UIScreen.main.bounds.height

let COLLECTION_USERS = Firestore.firestore().collection("users")
//let COLLECTION_LETTERS = Firestore.firestore().collection("letters")
let COLLECTION_STOPUSERSLIST = Firestore.firestore().collection("stopUsersList")

let fontBold28 = Font.system(size: 28, weight: .bold)
let fontBold24 = Font.system(size: 24, weight: .bold)
let fontBold16 = Font.system(size: 16, weight: .bold)
let fontBold12 = Font.system(size: 12, weight: .bold)
let fontMedium16 = Font.system(size: 16, weight: .medium)
let fontMedium12 = Font.system(size: 12, weight: .medium)
let fontRegular12 = Font.system(size: 12, weight: .regular)
let fontRegular8 = Font.system(size: 8, weight: .regular)
let fontLight16 = Font.system(size: 16, weight: .light)
let fontLight12 = Font.system(size: 12, weight: .light)

let Documents_Directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
let coordinateCentrMap = CLLocationCoordinate2D(latitude: 59.942963, longitude: 30.353370)
