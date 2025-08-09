//
//  DetailHeaderView.swift
//  TimeCounter
//
//  Created by Quang Nguyen on 7/8/25.
//

import Foundation
import SwiftUI

struct DetailHeaderView: View {
    @ObservedObject var viewModel: TDetailViewModel
    @Binding var pickDate: Date
    @State var changeTitle: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            RoundedRectangle(cornerRadius: 7).frame(width: 100, height: 1)
                .padding(.top, 5)
            
            VStack(alignment: .leading, spacing: 0) {
                Button {
                    changeTitle.toggle()
                } label: {
                    if !changeTitle {
                        Image(systemName: "pencil.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.ultraThinMaterial)
                            .frame(width: 20, height: 20)
                    } else {
                        Text("Done")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(.tint)
                    }
                }
                
                if changeTitle {
                    TextField("Title", text: $viewModel.counter.title)
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 32))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundColor(.black)
                        .background(.clear)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity, alignment: .leading)
                } else {
                    Text(viewModel.counter.title)
                        .font(.system(size: 40))
                        .fontWeight(.semibold)
                        .lineLimit(2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            
            HStack(alignment: .center) {
                Menu {
                    Button(CountType.daysSince.title, action: {
                        viewModel.counter.countType = .daysSince
                    })
                    Menu("Days Until") {
                        Button(DaysUntil.specificDate.rawValue, action: {
                            viewModel.counter.countType = .daysUntil(.specificDate)
                        })
                        Button(DaysUntil.anualYear.rawValue, action: {
                            viewModel.counter.countType = .daysUntil(.anualYear)
                        })
                        Button(DaysUntil.anualMonth.rawValue, action: {
                            viewModel.counter.countType = .daysUntil(.anualMonth)
                        })
                    }
                } label: {
                    Text(viewModel.counter.countType.title)
                        .font(.body)
                        .padding(7)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.ultraThinMaterial)
                                .opacity(0.2)
                        }
                }
                
                DatePicker(selection: $pickDate, displayedComponents: [.date, .hourAndMinute]) {}
                    .labelsHidden()
                    .colorScheme(.dark)
            }
            
            HStack {
                RoundedRectangle(cornerRadius: 7)
                    .frame(width: 50, height: 1)
                Spacer()
                RoundedRectangle(cornerRadius: 7)
                    .frame(width: 150, height: 1)
                Spacer()
            }
            .padding(.top, 6)
        }
        .frame(maxWidth: .infinity ,alignment: .leading)
    }
}
