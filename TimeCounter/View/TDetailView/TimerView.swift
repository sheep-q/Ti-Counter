//
//  TimerView.swift
//  TimeCounter
//
//  Created by nguyen.van.quangf on 17/05/2022.
//

import Foundation
import SwiftUI
import Lottie

struct TimerView: View {
    @State var nowDate: Date = Date()
    let referenceDate: Date
    let countkind: CountKinds
    @State var day: Bool = false
    @State var hour: Bool = false
    @State var min: Bool = false
    @State var second: Bool = false
    
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            self.nowDate = Date()
        }
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: -10) {
                HStack(alignment: .center) {
                    Text(countString(from:referenceDate, day: true))
                    Text("days")
                        .font(.custom(Technology.italic, size: 30))
                        .offset(y: 13)
                }
                HStack {
                    Text(countString(from:referenceDate, hour: true))
                    Text("hours")
                        .font(.custom(Technology.italic, size: 30))
                        .offset(y: 13)
                }
                HStack {
                    Text(countString(from:referenceDate, min: true))
                    Text("mins")
                        .font(.custom(Technology.italic, size: 30))
                        .offset(y: 13)
                }
            }
            .font(.custom(Technology.bold, size: 90))
            .onAppear(perform: {
                _ = self.timer
            })
        }
    }

    func countString(from date: Date, day: Bool = false, hour: Bool = false, min: Bool = false, second: Bool = false) -> String {
        let calendar = Calendar(identifier: .gregorian)
        var components = calendar
            .dateComponents([.year,.month, .day, .hour, .minute, .second],
                            from: referenceDate,
                            to: nowDate)
        
        switch countkind {
        case .default:
            break
        case .increase:
            components = calendar
                .dateComponents([.day, .hour, .minute, .second],
                                from: referenceDate,
                                to: nowDate)
        case .down:
            components = calendar
                .dateComponents([.day, .hour, .minute, .second],
                                from: nowDate,
                                to: referenceDate)
        }
        
        if day {
            return String(format: "%01d", components.day ?? 0)
        }
        
        if hour {
            return String(format: "%01d", components.hour ?? 0)
        }
        
        if min {
            return String(format: "%01d", components.minute ?? 0)
        }
        
        if second {
            return String(format: "%01d", components.second ?? 0)
        }
        
        return String(format: "%01dd:%01dh:%01dm:%01ds",
                      components.day ?? 0,
                      components.hour ?? 0,
                      components.minute ?? 0,
                      components.second ?? 0)
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
