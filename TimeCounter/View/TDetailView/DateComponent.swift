//
//  DateComponent.swift
//  TimeCounter
//
//  Created by nguyen.van.quangf on 19/05/2022.
//

import Foundation

struct DateComponent: Codable {
    enum Component: String, Codable, CaseIterable {
        case year, month, day, hour, minute, second
    }

    var activeComponents: Set<Component> = [.year, .month, .day]

    enum CodingKeys: CodingKey {
        case activeComponents
    }

    init() {}

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        activeComponents = try container.decode(Set<Component>.self, forKey: .activeComponents)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(activeComponents, forKey: .activeComponents)
    }
}
