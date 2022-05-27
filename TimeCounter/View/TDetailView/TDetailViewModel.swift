//
//  TDetailViewModel.swift
//  TimeCounter
//
//  Created by nguyen.van.quangf on 18/05/2022.
//

import Foundation

enum CountKinds: String {
    case `default` = "Kinds"
    case increase = "Count from"
    case down = "Count down"
}

class TDetailViewModel: ObservableObject {
    @Published var dateComponents = DateComponent()
    @Published var currentKindCount: CountKinds = .default
    @Published var title: String
    @Published var backgroundColor: String
    @Published var textCorlor: String
    @Published var currentAnimation: String
    @Published var lastAnimation: String = ""
    
    init(title: String = "Work From Home", backgroundColor: String = Palette.colorArray.first ?? "000000", textColor: String = Palette.textColor.first ?? "FFFFFF", currentAnimation: String = LottieImage.data.first ?? "87082-love-heart") {
        self.title = title
        self.backgroundColor = backgroundColor
        self.textCorlor = textColor
        self.currentAnimation = currentAnimation
    }
    
    func increaseKind() {
        currentKindCount = CountKinds.increase
    }
    func downKind() {
        currentKindCount = CountKinds.down
    }
}
