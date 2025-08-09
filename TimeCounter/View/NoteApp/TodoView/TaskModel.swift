//
//  Task.swift
//  TimeCounter
//
//  Created by Quang Nguyen on 5/22/22.
//

import Foundation

let dateFormatter = DateFormatter()

struct TaskModel: Identifiable, Codable {
    var id = UUID().uuidString
    
    enum CodingKeys: CodingKey {
        case dateCreated
        case isCheck
        case priority
        case title
        case notiDate
        case isNoti
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        dateCreated = try container.decode(Date.self, forKey: .dateCreated)
        isCheck = try container.decode(Bool.self, forKey: .isCheck)
        title = try container.decode(String.self, forKey: .title)
        notiDate = try container.decode(Date.self, forKey: .notiDate)
        isNoti = try container.decode(Bool.self, forKey: .isNoti)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(dateCreated, forKey: .dateCreated)
        try container.encode(isCheck, forKey: .isCheck)
        try container.encode(title, forKey: .title)
        try container.encode(notiDate, forKey: .notiDate)
        try container.encode(isNoti, forKey: .isNoti)
    }
    
    var dateCreated = Date()
    var isCheck: Bool = false
    var title: String = ""
    var notiDate = Date()
    var isNoti: Bool = false
    
    var dateCreatedString: String {
        dateFormatter.dateFormat = "MMM d yyyy, h:mm a"
        return dateFormatter.string(from: dateCreated)
    }
    
    var dateNotiString: String {
        dateFormatter.dateFormat = "MMM d yyyy, h:mm a"
        return dateFormatter.string(from: notiDate)
    }
    
    init(title: String, notiDate: Date = Date(), isNoti: Bool = false) {
        self.dateCreated = Date()
        self.title = title
        self.notiDate = notiDate
        self.isNoti = isNoti
    }
}
