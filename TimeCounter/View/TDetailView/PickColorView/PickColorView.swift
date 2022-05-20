//
//  PickColorView.swift
//  TimeCounter
//
//  Created by nguyen.van.quangf on 18/05/2022.
//

import SwiftUI

struct PickColorView: View {
    
    @State var isExpand = false
    @State var currentColor = Palette.colorArray.first!
    @State var currenTextColor = Palette.textColor.first!
    
    var isText = false
    let onchange: (_ value: String) -> Void
    
    init(isText: Bool = false,
         onchange: @escaping(_ value: String) -> Void
    ) {
        self.isText = isText
        self.onchange = onchange
    }
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                HStack(alignment: .center){
                    if isExpand {
                        Image(systemName: "chevron.forward")
                            .foregroundColor(Color(hex: Palette.gray))
                    } else {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(Color(hex: Palette.gray))
                    }
                    
                    if isText {
                        Text("A")
                            .font(.system(size: 30).bold())
                            .foregroundColor(Color(hex: currenTextColor))
                    } else {
                        Circle()
                            .foregroundColor(Color(hex: currentColor))
                            .frame(width: 40, height: 40)
                    }
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
                            if !isText {
                                ForEach(Palette.colorArray.indices, id: \.self) { index in
                                    Circle()
                                        .foregroundColor(Color(hex: Palette.colorArray[index]))
                                        .frame(width: 40, height: 40)
                                        .onTapGesture {
                                            onchange(Palette.colorArray[index])
                                            currentColor = Palette.colorArray[index]
                                        }
                                }
                            } else {
                                ForEach(Palette.textColor.indices, id: \.self) { index in
                                    Text("A")
                                        .font(.system(size: 30).bold())
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
        .padding(.trailing, 10)
    }
}

struct PickColorView_Previews: PreviewProvider {
    static var previews: some View {
        PickColorView(isText: true) { _ in }
        .background(.pink)
    }
}
