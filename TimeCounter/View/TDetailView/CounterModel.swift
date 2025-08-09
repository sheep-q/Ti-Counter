//
//  CounterModel.swift
//  TimeCounter
//
//  Created by Quang Nguyen on 7/8/25.
//

import Foundation

enum CountType: Codable, Equatable {
    case daysSince
    case daysUntil(DaysUntil)
    
    var title: String {
        switch self {
        case .daysSince:
            return "Days Since"
        case .daysUntil(let type):
            return type.rawValue
        }
    }

    enum CodingKeys: CodingKey {
        case daysSince
        case daysUntil
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if container.contains(.daysSince) {
            self = .daysSince
        } else if container.contains(.daysUntil) {
            let daysUntilType = try container.decode(DaysUntil.self, forKey: .daysUntil)
            self = .daysUntil(daysUntilType)
        } else {
            throw DecodingError.dataCorruptedError(
                forKey: .daysSince, in: container, debugDescription: "Invalid CountType")
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .daysSince:
            try container.encode(true, forKey: .daysSince)
        case .daysUntil(let daysUntilType):
            try container.encode(daysUntilType, forKey: .daysUntil)
        }
    }
}

enum DaysUntil: String, Codable {
    case specificDate = "Specific Date"
    case anualYear = "Anual Year"
    case anualMonth = "Anual Month"
}

struct CounterModel: Codable, Identifiable {
    let id = UUID()
    var dateComponents = DateComponent()
    var todoViewModel = TodoViewModel()
    var countType: CountType = .daysSince
    var title: String
    var backgroundColor: String
    var textCorlor: String
    var lottieImage: String

    enum CodingKeys: CodingKey {
        case dateComponents
        case todoViewModel
        case countType
        case title
        case backgroundColor
        case textCorlor
        case lottieImage
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(dateComponents, forKey: .dateComponents)
        try container.encode(todoViewModel, forKey: .todoViewModel)
        try container.encode(countType, forKey: .countType)
        try container.encode(title, forKey: .title)
        try container.encode(backgroundColor, forKey: .backgroundColor)
        try container.encode(textCorlor, forKey: .textCorlor)
        try container.encode(lottieImage, forKey: .lottieImage)
    }

    init(
        title: String = "Work From Home",
        backgroundColor: String = Palette.colorArray.first ?? "000000",
        textColor: String = Palette.textColor.first ?? "FFFFFF",
        lottieImage: String = LottieImage.data.first ?? "87082-love-heart"
    ) {
        self.title = title
        self.backgroundColor = backgroundColor
        self.textCorlor = textColor
        self.lottieImage = lottieImage
    }
}
