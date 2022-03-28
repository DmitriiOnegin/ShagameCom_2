//
//  ArtCreator.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 21.02.2022.
//

import Foundation
import MapKit

struct ArtCreator: Identifiable, Codable{
    
    var id = UUID()
    
    var artTitle: String = ""
    
    var artDescription: String = ""
    
    var artTripDescription: String = ""
    
    var artDuration: String = ""
    
    var artTown: String = ""
    
    var artTeam: String = ""
    
    var artLanguage: String = ""
    
    var artHashtags: String = ""
    
    var artLocations: [Mark] = [Mark(number: 0, name: "", coordinate: CLLocationCoordinate2D(latitude: 59.942963,
                                                                                             longitude: 30.353370), identifier: "")]
    
    var artMarshrut: [Mark] = []
    
    var artAudioURL = ""
    
    var artImageURL = ""
    
    var artType = "artPro"
    
}

//let testArts: [ArtCreator] = [testArt1, testArt2, testArt3]
//let testArt1 = ArtCreator(id: UUID(),
//                          artTitle: "Ахматова: я была дерзкой:",
//                          artDescription: "Спектакль начинается воспоминаниями о черноморском детстве Ахматовой, сменяется юношеской любовью Анны и приводит к страшным событиям 30-х годов двадцатого века.",
//                          artTripDescription: "Маршрут пройдет от улицы Петербурга от Фонтанного Дома до памятника Анны Андреевны напротив тюрьмы «Кресты»",
//                          artDuration: "90-120 минут или ≈8 300 шагов",
//                          artTown: "",
//                          artTeam: "Режиссер — Дина Верютина \n Звукорежиссер — Арсений Щедрин \n Художник-иллюстратор — Алексей Курбатов \n Актеры: \n Алина Os \n Игорь Устинович \n Дмитрий Бутеев \n Яна Савицкая",
//                          artLanguage: "",
//                          artHashtags: "",
//                          artLocations: epizods,
//                          artMarshrut: locations1,
//                          artAudioURL: "",
//                          artImageURL: "coverAhmatova")
//
//let testArt2 = ArtCreator(id: UUID(),
//                          artTitle: "Бродский",
//                          artDescription: "Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста",
//                          artTripDescription: "Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста",
//                          artDuration: "",
//                          artTown: "",
//                          artTeam: "Режиссер — Дина Верютина \n Звукорежиссер — Арсений Щедрин \n Художник-иллюстратор — Алексей Курбатов \n Актеры: \n Алина Os \n Игорь Устинович \n Дмитрий Бутеев \n Яна Савицкая Режиссер — Дина Верютина \n Звукорежиссер — Арсений Щедрин \n Художник-иллюстратор — Алексей Курбатов \n Актеры: \n Алина Os \n Игорь Устинович \n Дмитрий Бутеев \n Яна Савицкая",
//                          artLanguage: "",
//                          artHashtags: "",
//                          artLocations: epizods,
//                          artMarshrut: locations1,
//                          artAudioURL: "",
//                          artImageURL: "coverBrodskii")
//
//let testArt3 = ArtCreator(id: UUID(),
//                          artTitle: "Набоков",
//                          artDescription: "Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста",
//                          artTripDescription: "Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста Много много текста",
//                          artDuration: "",
//                          artTown: "",
//                          artTeam: "Режиссер — Дина Верютина \n Звукорежиссер — Арсений Щедрин \n Художник-иллюстратор — Алексей Курбатов \n Актеры: \n Алина Os \n Игорь Устинович \n Дмитрий Бутеев \n Яна Савицкая Режиссер — Дина Верютина \n Звукорежиссер — Арсений Щедрин \n Художник-иллюстратор — Алексей Курбатов \n Актеры: \n Алина Os \n Игорь Устинович \n Дмитрий Бутеев \n Яна Савицкая Режиссер — Дина Верютина \n Звукорежиссер — Арсений Щедрин \n Художник-иллюстратор — Алексей Курбатов \n Актеры: \n Алина Os \n Игорь Устинович \n Дмитрий Бутеев \n Яна Савицкая",
//                          artLanguage: "",
//                          artHashtags: "",
//                          artLocations: epizods,
//                          artMarshrut: locations1,
//                          artAudioURL: "",
//                          artImageURL: "coverNabokov")
//
//
//
