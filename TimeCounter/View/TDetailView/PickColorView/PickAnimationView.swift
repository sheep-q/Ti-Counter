//
//  PickAnimationView.swift
//  TimeCounter
//
//  Created by nguyen.van.quangf on 19/05/2022.
//

import SwiftUI

struct PickAnimationView: View {
    @State var isExpand = false
    @State var lottieImage = LottieImage.data.first!
    
    let onchange: (_ value: String) -> Void
    
    init(
        currenAnimation: String,
        onchange: @escaping(_ value: String) -> Void
    ) {
        self.lottieImage = currenAnimation
        self.onchange = onchange
    }
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                HStack(alignment: .center) {
                    if isExpand {
                        Image(systemName: "chevron.forward")
                    } else {
                        Image(systemName: "chevron.backward")
                    }
                    
                    Image(lottieImage)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                        .frame(width: 50, height: 50)
                }
                .onTapGesture {
                    withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                        isExpand.toggle()
                    }
                }
                
                if isExpand {
                    Rectangle()
                        .cornerRadius(10)
                        .frame(width: 1, height: 50)
                        .foregroundColor(Color(hex: Palette.gray))
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack {
                            ForEach(LottieImage.data.indices, id: \.self) { index in
                                Image(LottieImage.data[index])
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(10)
                                    .frame(width: 50, height: 50)
                                    .onTapGesture {
                                        lottieImage = LottieImage.data[index]
                                        onchange(LottieImage.data[index])
                                    }
                            }
                        }
                    }
                }
            }
            .padding(5)
            .background {
                RoundedRectangle(cornerRadius: CGFloat(10))
                    .fill(.ultraThinMaterial)
                    .opacity(buttonOpacity)
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}

struct PickAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        PickAnimationView(currenAnimation: "") { _ in }
    }
}
