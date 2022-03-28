//
//  Description.swift
//  ShagameCom
//
//  Created by Dmitrii Onegin on 02.02.2022.
//

import Foundation

enum Description: String {
    case firstScreen
    case secondScreen
    case thirdScreen
    
    var titul: (fonImage: String, mainImage: String, title: String, subTitle: String, buttonIcon: String, id: Int) {
        switch self {
        case .firstScreen:
            return ("background", "FrameShagame", "SHAGAME — звуковая карта", "Создавайте аудиобоксы,\n размещайте их на карте.\n Слушайте и изучайте\n пространство.", "next Icon white", 0)
        case .secondScreen:
            return ("background", "Frame 1", "Подключите наушники", "Это создаст эффект полного\n погружения в звуковое\n пространство", "next Icon", 1)
        case .thirdScreen:
            return ("background", "Frame 2", "Разрешите приложению отслеживать геопозицию", "Вы посмотрите на город по новому.\n Включите функцию геолокации,\n чтобы авторы провели вас по улицам\n и местам с которым связано\n содержание аудиобоксов.", "next Icon", 2)
        }
    }
}
