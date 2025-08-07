//
//  CounterModel.swift
//  TimeCounter
//
//  Created by Quang Nguyen on 7/8/25.
//

import Foundation

enum CountKinds: String, Codable {
    case `default` = "Kinds"
    case increase = "Count from"
    case down = "Count down"
}

class CounterModel: Codable, Identifiable {
    var dateComponents = DateComponent()
    var todoViewModel = TodoViewModel()
    var currentKindCount: CountKinds = .default
    var title: String
    var backgroundColor: String
    var textCorlor: String
    var currentAnimation: String
    var lastAnimation: String = ""
    
    enum CodingKeys: CodingKey {
        case dateComponents
        case todoViewModel
        case currentKindCount
        case title
        case backgroundColor
        case textCorlor
        case currentAnimation
        case lastAnimation
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        dateComponents = try container.decode(DateComponent.self, forKey: .dateComponents)
        todoViewModel = try container.decode(TodoViewModel.self, forKey: .todoViewModel)
        currentKindCount = try container.decode(CountKinds.self, forKey: .currentKindCount)
        title = try container.decode(String.self, forKey: .title)
        backgroundColor = try container.decode(String.self, forKey: .backgroundColor)
        textCorlor = try container.decode(String.self, forKey: .textCorlor)
        currentAnimation = try container.decode(String.self, forKey: .currentAnimation)
        lastAnimation = try container.decode(String.self, forKey: .lastAnimation)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(dateComponents, forKey: .dateComponents)
        try container.encode(todoViewModel, forKey: .todoViewModel)
        try container.encode(currentKindCount, forKey: .currentKindCount)
        try container.encode(title, forKey: .title)
        try container.encode(backgroundColor, forKey: .backgroundColor)
        try container.encode(textCorlor, forKey: .textCorlor)
        try container.encode(currentAnimation, forKey: .currentAnimation)
        try container.encode(lastAnimation, forKey: .lastAnimation)
    }
    
    init(title: String = "Work From Home", backgroundColor: String = Palette.colorArray.first ?? "000000", textColor: String = Palette.textColor.first ?? "FFFFFF", currentAnimation: String = LottieImage.data.first ?? "87082-love-heart") {
        self.title = title
        self.backgroundColor = backgroundColor
        self.textCorlor = textColor
        self.currentAnimation = currentAnimation
    }
}
