//
//  Task.swift
//  TimeCounter
//
//  Created by Quang Nguyen on 5/22/22.
//

import Foundation

class TaskModel: ObservableObject, Identifiable {
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
        return dateFormatter.string(from: dateCreated)
    }
    
    init(title: String, priority: String, notiDate: Date = Date(), isNoti: Bool = false) {
        self.dateCreated = Date()
        self.title = title
        self.priority = priority
        self.notiDate = notiDate
        self.isNoti = isNoti
    }
}
