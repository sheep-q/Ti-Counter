//
//  PickColorView.swift
//  TimeCounter
//
//  Created by nguyen.van.quangf on 18/05/2022.
//

import SwiftUI

struct PickColorView: View {
    
    @State var isExpand = false
    @State var currentColor: String
    @State var currenTextColor: String
    
    var isText = false
    let onchange: (_ value: String) -> Void
    
    var sizeOfText: CGFloat {
        isExpand ? 35 : 25
    }
    
    var sizeOfColor: CGFloat {
        isExpand ? 45 : 35
    }
    
    init(isText: Bool = false,
         currentColor: String,
         currentTextColor: String,
         onchange: @escaping(_ value: String) -> Void
    ) {
        self.isText = isText
        self.currentColor = currentColor
        self.currenTextColor = currentTextColor
        self.onchange = onchange
    }
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                HStack(alignment: .center){
                    if isExpand {
                        Image(systemName: "chevron.forward")
                    } else {
                        Image(systemName: "chevron.backward")
                    }
                    
                    if isText {
                        Text("A")
                            .font(.system(size: sizeOfText).bold())
                            .foregroundColor(Color(hex: currenTextColor))
                    } else {
                        Circle()
                            .foregroundColor(Color(hex: currentColor))
                            .frame(width: sizeOfColor, height: sizeOfColor)
                    }
                }
                .onTapGesture {
                    withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                        isExpand.toggle()
                    }
                }
                
                if isExpand {
                    Rectangle()
                        .frame(width: 1, height: 50)
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack {
                            if !isText {
                                ForEach(Palette.colorArray.indices, id: \.self) { index in
                                    Circle()
                                        .foregroundColor(Color(hex: Palette.colorArray[index]))
                                        .frame(width: sizeOfColor, height: sizeOfColor)
                                        .onTapGesture {
                                            onchange(Palette.colorArray[index])
                                            currentColor = Palette.colorArray[index]
                                        }
                                }
                            } else {
                                ForEach(Palette.textColor.indices, id: \.self) { index in
                                    Text("A")
                                        .font(.system(size: sizeOfText).bold())
                                        .foregroundColor(Color(hex: Palette.textColor[index]))
                                        .onTapGesture {
                                            currenTextColor = Palette.textColor[index]
                                            onchange(Palette.textColor[index])
                                        }
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
            }
            
        }
        .frame(alignment: .trailing)
    }
}

struct PickColorView_Previews: PreviewProvider {
    static var previews: some View {
        PickColorView(isText: true,
                      currentColor: "",
                      currentTextColor: ""
        ) { _ in }
        .background(.pink)
    }
}
