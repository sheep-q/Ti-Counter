//
//  TimerView.swift
//  TimeCounter
//
//  Created by nguyen.van.quangf on 17/05/2022.
//

import Foundation
import Lottie
import SwiftUI

struct TimerView: View {
    @State var dateComponent: DateComponent

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
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.nowDate = Date()
        }
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(alignment: .leading, spacing: -10) {
                Spacer().frame(height: 50)
                ForEach(DateComponent.Component.allCases, id: \.self) { component in
                    if dateComponent.activeComponents.contains(component) {
                        HStack(alignment: .center) {
                            Text(countString(from: referenceDate, component: component))
                            Text(component.rawValue.capitalized)
                                .font(.custom(Technology.italic, size: componentFont))
                                .offset(y: componentOffset)
                        }
                    }
                }
            }

            VStack(alignment: .leading) {
                if isExpand {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(DateComponent.Component.allCases, id: \.self) { component in
                            Button {
                                if dateComponent.activeComponents.contains(component) {
                                    dateComponent.activeComponents.remove(component)
                                } else {
                                    dateComponent.activeComponents.insert(component)
                                }
                            } label: {
                                HStack {
                                    Text(component.rawValue.capitalized)
                                    Spacer()
                                    if dateComponent.activeComponents.contains(component) {
                                        Image(systemName: "checkmark")
                                    }
                                }
                            }
                            Divider()
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
                            .opacity(isExpand ? 1 : 0.2)
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

    func dateComponentSet() -> Set<Calendar.Component> {
        var set = Set<Calendar.Component>()

        for component in dateComponent.activeComponents {
            switch component {
            case .year:
                set.insert(.year)
            case .month:
                set.insert(.month)
            case .day:
                set.insert(.day)
            case .hour:
                set.insert(.hour)
            case .minute:
                set.insert(.minute)
            case .second:
                set.insert(.second)
            }
        }
        return set
    }

    func countString(from date: Date, component: DateComponent.Component) -> String {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(
            dateComponentSet(), from: referenceDate, to: nowDate)

        switch component {
        case .year:
            return String(format: "%01d", components.year ?? 0)
        case .month:
            return String(format: "%01d", components.month ?? 0)
        case .day:
            return String(format: "%01d", components.day ?? 0)
        case .hour:
            return String(format: "%01d", components.hour ?? 0)
        case .minute:
            return String(format: "%01d", components.minute ?? 0)
        case .second:
            return String(format: "%01d", components.second ?? 0)
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
