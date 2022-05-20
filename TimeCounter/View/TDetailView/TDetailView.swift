//
//  TDetailView.swift
//  TimeCounter
//
//  Created by nguyen.van.quangf on 18/05/2022.
//

import SwiftUI

struct TDetailView: View {
    @ObservedObject var viewModel = TDetailViewModel()
    @ObservedObject var dateComponent = DateComponent()
    @State private var pickDate = Date()
    @State private var title = "Work From Home"
    @State private var changeTitle = false
    
    var body: some View {
        ZStack {
            Color(hex: viewModel.backgroundColor)
                .ignoresSafeArea()
            
            // lack reload animation when reload view
            LottieView(name: viewModel.currentAnimation,
                       lastName: viewModel.lastAnimation,
                       loopMode: .playOnce)
                .frame(height: 400)
                .offset(x: 75, y: -50)
                .scaleEffect(1)
            
            VStack(alignment: .leading) {
                Spacer().frame(height: 40)
                RoundedRectangle(cornerRadius: 7).frame(width: 100, height: 1)
                VStack(alignment: .leading, spacing: -15) {
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
                        TextField("Title of Ti-Count", text: $viewModel.title)
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 40))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .foregroundColor(.gray)
                            .background(.clear)
                            .frame(maxWidth: 250, minHeight: 130, alignment: .leading)
                    } else {
                        Text(viewModel.title)
                            .font(.system(size: 40))
                            .fontWeight(.semibold)
                            .lineLimit(2)
                            .frame(maxWidth: 250, maxHeight: 130, alignment: .leading)
                    }
                }
                
                HStack(alignment: .center) {
                    Menu {
                        Button(CountKinds.increase.rawValue, action: viewModel.increaseKind)
                        Button(CountKinds.down.rawValue, action: viewModel.downKind)
                    } label: {
                        Text(viewModel.currentKindCount.rawValue)
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
                
                TimerView(dateComponent: dateComponent,
                          referenceDate: pickDate,
                          countkind: viewModel.currentKindCount)
                    .padding(.top, 0)
                Spacer()
            }
            .padding(.leading, 30)
            .frame(maxWidth: .infinity ,alignment: .leading)
            
            VStack(alignment: .trailing) {
                Spacer()
                PickColorView(isText: true) { value in
                    viewModel.textCorlor = value
                }
                
                PickColorView { value in
                    viewModel.backgroundColor = value
                }
                
                PickAnimationView { value in
                    guard viewModel.currentAnimation != value else {
                        return
                    }
                    viewModel.lastAnimation = viewModel.currentAnimation
                    viewModel.currentAnimation = value
                }
            }
            .padding(.leading, 20)
        }
        .foregroundColor(Color(hex: viewModel.textCorlor))
    }
}

struct TDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TDetailView()
    }
}
