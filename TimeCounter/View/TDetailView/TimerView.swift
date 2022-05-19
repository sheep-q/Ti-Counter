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
    @State var isYear = false
    @State var isMonth = false
    @State var isDay = true
    @State var isHour = false
    @State var isMin = false
    @State var isSecond = false
    
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            self.nowDate = Date()
        }
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: -10) {
                Button {
                    //
                } label: {
                    Label {
                        Text("Type")
                            .font(.body)
                    } icon: {
                        Image(systemName: "pencil.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                }
                .padding(5)
                .background {
                    RoundedRectangle(cornerRadius: 7)
                        .fill(.ultraThinMaterial)
                }
                .padding(.bottom)

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
    
    func dateComponent() -> Set<Calendar.Component> {
        var set = Set<Calendar.Component>()
        
        if isYear {
            set.insert(.year)
        }
        if isMonth {
            set.insert(.month)
        }
        if isDay {
            set.insert(.day)
        }
        if isHour {
            set.insert(.hour)
        }
        if isMin {
            set.insert(.minute)
        }
        if isSecond {
            set.insert(.second)
        }
        return set
    }

    func countString(from date: Date, year: Bool = false, month: Bool = false, day: Bool = false, hour: Bool = false, min: Bool = false, second: Bool = false) -> String {
        let calendar = Calendar(identifier: .gregorian)
        var components = calendar
            .dateComponents(dateComponent(),
                            from: referenceDate,
                            to: nowDate)
        
        switch countkind {
        case .default:
            break
        case .increase:
            components = calendar
                .dateComponents(dateComponent(),
                                from: referenceDate,
                                to: nowDate)
        case .down:
            components = calendar
                .dateComponents(dateComponent(),
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
