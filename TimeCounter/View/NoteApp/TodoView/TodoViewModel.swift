//
//  TodoViewModel.swift
//  TimeCounter
//
//  Created by Quang Nguyen on 5/22/22.
//

import Foundation
import SwiftUI
import Swift

class TodoViewModel: ObservableObject, Codable {
    
    enum CodingKeys: CodingKey {
        case allTask
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        allTasks = try container.decode([TaskModel].self, forKey: .allTask)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(allTasks, forKey: .allTask)
    }
    
    @Published var allTasks = [TaskModel]()
    @Published var title: String = ""
    @Published var notiDate = Date()
    @Published var isNoti = false
    
    let notificationManager = NotificationManager()
    
    init() {
        self.allTasks.append(TaskModel(title: "10/5 đi khám định kỳ, buộc chun lúc đi ngủ "))
        self.allTasks.append(TaskModel(title: "Thay niềng răng, kéo răng cửa", notiDate: Date(), isNoti: true))
        self.allTasks.append(TaskModel(title: "28/8 du lịch Hải Phòng lần đầu tiên"))
    }
    
    func move(from source: IndexSet, to destination: Int) {
            allTasks.move(fromOffsets: source, toOffset: destination)
        }
    
    func appendTask() {
        if isNoti {
            let content = UNMutableNotificationContent()
            content.body = title
            content.sound = UNNotificationSound.default
            content.userInfo = [
                "notificationId": "\(title)" // additional info to parse if need
            ]
            
            let dateMatching = Calendar.current.dateComponents([.timeZone, .year, .month, .hour, .minute, .second], from: notiDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateMatching, repeats: false)
            
            notificationManager.scheduleNotification(
                id: title,
                content: content,
                trigger: trigger
            )
        }
        allTasks.append(
            TaskModel(
                title: title,
                notiDate: notiDate,
                isNoti: isNoti
            )
        )
        title = ""
        isNoti = false
    }
    
    func deleteTask(at offsets: IndexSet) {
        offsets.forEach { index in
            if allTasks[index].isNoti {
                notificationManager.removePendingNotification(id: allTasks[index].title)
            }
            allTasks.remove(at: index)
        }
    }
    
    func toggleCheck(index: Int) {
        allTasks[index].isCheck.toggle()
        self.objectWillChange.send()
    }
    
    func setupNotifications() {
        notificationManager.notificationCenter.delegate = notificationManager
        notificationManager.handleNotification = handleNotification

        requestNotificationsPermission()
    }
    
    private func handleNotification(notification: UNNotification) {
        print("<<<DEV>>> Notification received: \(notification.request.content.userInfo)")
    }
    
    private func requestNotificationsPermission() {
        notificationManager.requestPermission(completionHandler: { isGranted, error in
            if isGranted {
                // handle granted success
            }

            if let _ = error {
                // handle error
                
                return
            }
        })
    }
}
