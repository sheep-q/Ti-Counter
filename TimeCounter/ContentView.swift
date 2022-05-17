//
//  ContentView.swift
//  TimeCounter
//
//  Created by nguyen.van.quangf on 17/05/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var pickDate = Date()
    @State private var title = "Work From Home"
    @State private var changeTitle = false
    
    var body: some View {
        ZStack {
//            Color(hex: Palette.colorArray.randomElement() ?? "fcbf49")
            Color(hex: "ff595e")
                .ignoresSafeArea()
            
            LottieView(name: "91956-work-from-home", loopMode: .loop)
                .frame(height: 600)
                .offset(x: 50, y: -50)
                .scaleEffect(1.2)
            
            VStack(alignment: .leading) {
                
                Spacer()
                    .frame(height: 40)
                
                RoundedRectangle(cornerRadius: 7)
                    .frame(width: 100, height: 1)
                
                HStack(alignment: .bottom) {
                    
                    if changeTitle {
                        TextField("Title of Ti-Count", text: $title)
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 40))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .foregroundColor(.gray)
                            .background(.clear)
                            .frame(maxWidth: 250, minHeight: 130, alignment: .leading)
                            
                    } else {
                        Text(title)
                            .font(.system(size: 40))
                            .fontWeight(.semibold)
                            .lineLimit(2)
                            .frame(maxWidth: 250, maxHeight: 130, alignment: .leading)
                    }
                    
                    Button {
                        changeTitle.toggle()
                    } label: {
                        Image(systemName: "pencil.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.ultraThinMaterial)
                            .frame(width: 20, height: 20)
                    }
                    .padding()
                    
                    Spacer()
                }
                
                
                DatePicker(selection: $pickDate, displayedComponents: [.date, .hourAndMinute]) {
                    
                }
                .labelsHidden()
                .colorScheme(.light)
                .colorInvert()
                .padding(.top, -15)
                .padding(.bottom, 5)
                
                HStack {
                    RoundedRectangle(cornerRadius: 7)
                        .frame(width: 50, height: 0.5)
                    Spacer()
                    RoundedRectangle(cornerRadius: 7)
                        .frame(width: 150, height: 1)
                    Spacer()
                }
                .padding(.vertical, 0)
                
                TimerView(referenceDate: pickDate)
                    .padding(.top, 30)
                
                Spacer()
            }
            .padding(.leading, 30)
            .frame(maxWidth: .infinity ,alignment: .leading)
        }
        .foregroundColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
