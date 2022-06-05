//
//  DateComponent.swift
//  TimeCounter
//
//  Created by nguyen.van.quangf on 19/05/2022.
//

import Foundation

class DateComponent: ObservableObject, Codable {
    @Published var isYear = true
    @Published var isMonth = true
    @Published var isDay = true
    @Published var isHour = false
    @Published var isMin = false
    @Published var isSecond = false
    
    enum CodingKeys: CodingKey {
        case isYear
        case isMonth
        case isDay
        case isHour
        case isMin
        case isSecond
    }
    
    init() {
        
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isYear = try container.decode(Bool.self, forKey: .isYear)
        isMonth = try container.decode(Bool.self, forKey: .isMonth)
        isDay = try container.decode(Bool.self, forKey: .isDay)
        isHour = try container.decode(Bool.self, forKey: .isHour)
        isMin = try container.decode(Bool.self, forKey: .isMin)
        isSecond = try container.decode(Bool.self, forKey: .isSecond)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(isYear, forKey: .isYear)
        try container.encode(isMonth, forKey: .isMonth)
        try container.encode(isDay, forKey: .isDay)
        try container.encode(isHour, forKey: .isHour)
        try container.encode(isMin, forKey: .isMin)
        try container.encode(isSecond, forKey: .isSecond)
    }
}
