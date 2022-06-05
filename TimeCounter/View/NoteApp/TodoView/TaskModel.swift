//
//  Task.swift
//  TimeCounter
//
//  Created by Quang Nguyen on 5/22/22.
//

import Foundation

let dateFormatter = DateFormatter()

class TaskModel: ObservableObject, Identifiable, Codable {
    
    enum CodingKeys: CodingKey {
        case dateCreated
        case isCheck
        case priority
        case title
        case notiDate
        case isNoti
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        dateCreated = try container.decode(Date.self, forKey: .dateCreated)
        isCheck = try container.decode(Bool.self, forKey: .isCheck)
        priority = try container.decode(String.self, forKey: .priority)
        title = try container.decode(String.self, forKey: .title)
        notiDate = try container.decode(Date.self, forKey: .notiDate)
        isNoti = try container.decode(Bool.self, forKey: .isNoti)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(dateCreated, forKey: .dateCreated)
        try container.encode(isCheck, forKey: .isCheck)
        try container.encode(priority, forKey: .priority)
        try container.encode(title, forKey: .title)
        try container.encode(notiDate, forKey: .notiDate)
        try container.encode(isNoti, forKey: .isNoti)
    }
    
    @Published var dateCreated = Date()
    @Published var isCheck: Bool = false
    @Published var priority: String = ""
    @Published var title: String = ""
    @Published var notiDate = Date()
    @Published var isNoti: Bool = false
    
    var dateCreatedString: String {
        dateFormatter.dateFormat = "MMM d yyyy, h:mm a"
        return dateFormatter.string(from: dateCreated)
    }
    
    var dateNotiString: String {
        dateFormatter.dateFormat = "MMM d yyyy, h:mm a"
        return dateFormatter.string(from: notiDate)
    }
    
    init(title: String, priority: String, notiDate: Date = Date(), isNoti: Bool = false) {
        self.dateCreated = Date()
        self.title = title
        self.priority = priority
        self.notiDate = notiDate
        self.isNoti = isNoti
    }
}
