//
//  TodoViewModel.swift
//  TimeCounter
//
//  Created by Quang Nguyen on 5/22/22.
//

import Foundation
import SwiftUI

enum Priority: String, Identifiable, CaseIterable {
    
    var id: UUID {
        return UUID()
    }
    
    case low = "Low"
    case medium = "Medium"
    case high = "High"
}

extension Priority {
    
    var title: String {
        switch self {
            case .low:
                return "Low"
            case .medium:
                return "Medium"
            case .high:
                return "High"
        }
    }
}

class TodoViewModel: ObservableObject {
    @Published var allTasks = [TaskModel]()
    @Published var title: String = ""
    @Published var selectedPriority: Priority = .medium
    @Published var notiDate = Date()
    @Published var isNoti = false
    
    init() {
        self.allTasks.append(TaskModel(title: "10/5 đi khám định kỳ, buộc chun lúc đi ngủ ", priority: Priority.medium.rawValue))
        self.allTasks.append(TaskModel(title: "Thay niềng răng, kéo răng cửa", priority: Priority.high.rawValue, notiDate: Date(), isNoti: true))
        self.allTasks.append(TaskModel(title: "28/8 du lịch Hải Phòng lần đầu tiên", priority: Priority.low.rawValue))
    }
    
    func appendTask() {
        allTasks.append(TaskModel(title: title,
                                  priority: selectedPriority.rawValue,
                                  notiDate: notiDate,
                                  isNoti: isNoti))
    }
    
    func deleteTask(at offsets: IndexSet) {
        offsets.forEach { index in
           allTasks.remove(at: index)
        }
    }
    
    func styleForPriority(_ value: String) -> Color {
        let priority = Priority(rawValue: value)
        
        switch priority {
            case .low:
                return Color.orange
            case .medium:
                return Color.green
            case .high:
                return Color.red
            default:
                return Color.black
        }
    }
    
    func toggleCheck(index: Int) {
        allTasks[index].isCheck.toggle()
        self.objectWillChange.send()
    }
}
