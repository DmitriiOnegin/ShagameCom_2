//
//  Notification.swift
//  ShagameCom
//
//  Created by Arslan Abdullaev on 27.03.2022.
//

import SwiftUI

enum Notification {
    case claimOk
    case registerForListen
    case attentionWantDelete
    case ageAttention
    case shareWhenBoxDownloaded
    
    var notice: (text: String, firstButtonImage: String, secondButtonImage: String? ) {
        switch self{
            
        case .claimOk:
            return ("Мы рассмотрим вашу жалобу в\nближайшее время", "Group 6", nil)
        case .registerForListen:
            return ("Зарегистрируйтесь, чтобы\nначать прослушивание", "Group 8", "Group 62")
        case .attentionWantDelete:
            return ("Удалить проект\nбезвозвратно?", "Group 8-1", "Group 62-1")
        case .ageAttention:
            return ("Ограничение по возрасту\nв соответствиис Федеральным\nзаконом Российской Федерации\nот 29 декабря 2010 г. N 436-ФЗ\n«О защите детей от информации,\nпричиняющей вред их здоровью\nи развитию»", "Group 6-1", nil)
        case .shareWhenBoxDownloaded:
            return ("Поздравляем!\nВаш аудиобокс уже доступен\nдля прослушивания.\nПоделиться с друзьями?", "Group 8-2", "Group 62")
        }
    }
}

