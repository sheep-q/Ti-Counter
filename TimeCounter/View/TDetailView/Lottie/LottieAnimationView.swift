//
//  LottieAnimationView.swift
//  TimeCounter
//
//  Created by nguyen.van.quangf on 19/05/2022.
//

import SwiftUI

struct LottieAnimationView: View {
    @State var name: String
    var body: some View {
        ZStack {
            LottieView(name: name)
        }
    }
}

struct LottieAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        LottieAnimationView(name: "105188-berry-the-old-man")
    }
}
