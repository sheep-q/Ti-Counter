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
    
    var dateText: String {
        dateFormatter.dateFormat = "MMM d yyyy, h:mm a"
        return dateFormatter.string(from: dateCreated)
    }
    
    init(title: String, priority: String) {
        self.dateCreated = Date()
        self.title = title
        self.priority = priority
    }
}
