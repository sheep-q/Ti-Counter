//
//  DateComponent.swift
//  TimeCounter
//
//  Created by nguyen.van.quangf on 19/05/2022.
//

import Foundation

class DateComponent: ObservableObject {
    @Published var isYear = true
    @Published var isMonth = true
    @Published var isDay = true
    @Published var isHour = false
    @Published var isMin = false
    @Published var isSecond = false
    
    @Published var count: Int = 3
    
    func countComponents(){
        count = (isYear ? 1 : 0) + (isMonth ? 1 : 0) + (isDay ? 1 : 0) + (isHour ? 1 : 0) + (isMin ? 1 : 0) + (isSecond ? 1 : 0)
        self.objectWillChange.send()
    }
}
