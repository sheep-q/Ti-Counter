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
    @ObservedObject var dateComponent: DateComponent
    
    @State var nowDate: Date = Date()
    @State var isExpand = false
    let referenceDate: Date
    let countkind: CountKinds
    let componentFont: CGFloat = 17
    let componentOffset: CGFloat = 15
    init(
        dateComponent: DateComponent,
        referenceDate: Date,
        countkind: CountKinds = .default
    ) {
        self.dateComponent = dateComponent
        self.referenceDate = referenceDate
        self.countkind = countkind
    }
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            self.nowDate = Date()
        }
    }
    
    var body: some View {
        ZStack {
            ZStack(alignment: .topLeading) {
                VStack(alignment: .leading, spacing: -10) {
                    Spacer().frame(height: 50)
                    if dateComponent.isYear {
                        HStack(alignment: .center) {
                            Text(countString(from:referenceDate, year: true))
                            Text("years")
                                .font(.custom(Technology.italic, size: componentFont))
                                .offset(y: componentOffset)
                        }
                    }
                    
                    if dateComponent.isMonth {
                        HStack(alignment: .center) {
                            Text(countString(from:referenceDate, month: true))
                            Text("months")
                                .font(.custom(Technology.italic, size: componentFont))
                                .offset(y: componentOffset)
                        }
                    }
                    
                    if dateComponent.isDay {
                        HStack(alignment: .center) {
                            Text(countString(from:referenceDate, day: true))
                            Text("days")
                                .font(.custom(Technology.italic, size: componentFont))
                                .offset(y: componentOffset)
                        }
                    }
                    
                    if dateComponent.isHour {
                        HStack {
                            Text(countString(from:referenceDate, hour: true))
                            Text("hours")
                                .font(.custom(Technology.italic, size: componentFont))
                                .offset(y: componentOffset)
                        }
                    }
                    
                    if dateComponent.isMin {
                        HStack {
                            Text(countString(from:referenceDate, min: true))
                            Text("mins")
                                .font(.custom(Technology.italic, size: componentFont))
                                .offset(y: componentOffset)
                        }
                    }
                    
                    if dateComponent.isSecond {
                        HStack {
                            Text(countString(from:referenceDate, second: true))
                            Text("sec")
                                .font(.custom(Technology.italic, size: componentFont))
                                .offset(y: componentOffset)
                        }
                    }
                }
                
                // MARK: - List type
                VStack(alignment: .leading) {
                    if isExpand {
                        VStack(alignment: .leading, spacing: 10) {
                            VStack {
                                Button {
                                    dateComponent.isYear.toggle()
                                } label: {
                                    HStack {
                                        Text("Year")
                                        Spacer()
                                        if dateComponent.isYear {
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                }
                                Divider()
                                Button {
                                    dateComponent.isMonth.toggle()
                                } label: {
                                    HStack {
                                        Text("Month")
                                        Spacer()
                                        if dateComponent.isMonth {
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                }
                                Divider()
                                Button {
                                    dateComponent.isDay.toggle()
                                } label: {
                                    HStack {
                                        Text("Day")
                                        Spacer()
                                        if dateComponent.isDay {
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                }
                            }
                            Divider()
                            VStack {
                                Button {
                                    dateComponent.isHour.toggle()
                                } label: {
                                    HStack {
                                        Text("Hour")
                                        Spacer()
                                        if dateComponent.isHour {
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                }
                                Divider()
                                Button {
                                    dateComponent.isMin.toggle()
                                } label: {
                                    HStack {
                                        Text("Minutes")
                                        Spacer()
                                        if dateComponent.isMin {
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                }
                                Divider()
                                Button {
                                    dateComponent.isSecond.toggle()
                                } label: {
                                    HStack {
                                        Text("Second")
                                        Spacer()
                                        if dateComponent.isSecond {
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                }
                            }
                        }
                        .font(.body)
                        .foregroundColor(.black)
                        .padding(10)
                        .frame(width: 200)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.ultraThinMaterial)
                        }
                    }
                    Button {
                        withAnimation {
                            isExpand.toggle()
                        }
                    } label: {
                        Label {
                            Text("Type")
                                .font(.body)
                        } icon: {
                            if !isExpand {
                                Image(systemName: "chevron.down")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 15, height: 15)
                            } else {
                                Image(systemName: "chevron.up")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 15, height: 15)
                            }
                        }
                        .padding(5)
                        .background {
                            RoundedRectangle(cornerRadius: 7)
                                .fill(.ultraThinMaterial)
                                .opacity(isExpand ? 1 : buttonOpacity)
                        }
                        .padding(.bottom)
                    }
                }
            }
            .font(.custom(Technology.bold, size: 90))
            .onAppear(perform: {
                _ = self.timer
            })
        }
    }
    
    func dateComponentSet() -> Set<Calendar.Component> {
        var set = Set<Calendar.Component>()
        
        if dateComponent.isYear {
            set.insert(.year)
        }
        if dateComponent.isMonth {
            set.insert(.month)
        }
        if dateComponent.isDay {
            set.insert(.day)
        }
        if dateComponent.isHour {
            set.insert(.hour)
        }
        if dateComponent.isMin {
            set.insert(.minute)
        }
        if dateComponent.isSecond {
            set.insert(.second)
        }
        return set
    }

    func countString(from date: Date, year: Bool = false, month: Bool = false, day: Bool = false, hour: Bool = false, min: Bool = false, second: Bool = false) -> String {
        let calendar = Calendar(identifier: .gregorian)
        var components = calendar
            .dateComponents(dateComponentSet(),
                            from: referenceDate,
                            to: nowDate)
        
        switch countkind {
        case .default:
            break
        case .increase:
            components = calendar
                .dateComponents(dateComponentSet(),
                                from: referenceDate,
                                to: nowDate)
        case .down:
            components = calendar
                .dateComponents(dateComponentSet(),
                                from: nowDate,
                                to: referenceDate)
        }
        
        if year {
            return String(format: "%01d", components.year ?? 0)
        }
        
        if month {
            return String(format: "%01d", components.month ?? 0)
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
