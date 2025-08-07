//
//  CounterHeaderView.swift
//  TimeCounter
//
//  Created by Quang Nguyen on 7/8/25.
//

import Foundation
import SwiftUI

struct CounterHeaderView: View {
    @ObservedObject var viewModel: TDetailViewModel
    @Binding var pickDate: Date
    @State var changeTitle: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 7).frame(width: 100, height: 1)
                .padding(.top, 5)
            
            VStack(alignment: .leading, spacing: 0) {
                Button {
                    changeTitle.toggle()
                } label: {
                    Image(systemName: "pencil.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.ultraThinMaterial)
                        .frame(width: 20, height: 20)
                }
                
                if changeTitle {
                    TextField("Title of Ti-Count", text: $viewModel.counter.title)
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 40))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundColor(.gray)
                        .background(.clear)
                        .frame(maxWidth: 250, alignment: .leading)
                } else {
                    Text(viewModel.counter.title)
                        .font(.system(size: 40))
                        .fontWeight(.semibold)
                        .lineLimit(2)
                        .frame(maxWidth: 250, alignment: .leading)
                }
            }
            
            HStack(alignment: .center) {
                Menu {
                    Button(CountKinds.increase.rawValue, action: viewModel.increaseKind)
                    Button(CountKinds.down.rawValue, action: viewModel.downKind)
                } label: {
                    Text(viewModel.counter.currentKindCount.rawValue)
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
                    .colorScheme(.light)
                    .colorInvert()
            }
            .padding(.top, -15)
            .padding(.bottom, 0)
            
            HStack {
                RoundedRectangle(cornerRadius: 7)
                    .frame(width: 50, height: 0.5)
                Spacer()
                RoundedRectangle(cornerRadius: 7)
                    .frame(width: 150, height: 1)
                Spacer()
            }
            .padding(.vertical, 0)
        }
        .frame(maxWidth: .infinity ,alignment: .leading)
    }
}
