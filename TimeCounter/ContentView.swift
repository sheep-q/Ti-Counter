//
//  ContentView.swift
//  TimeCounter
//
//  Created by nguyen.van.quangf on 17/05/2022.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            TDetailView(
                viewModel: TDetailViewModel(title: "Orthodontics",
                                            backgroundColor: Palette.colorArray.first!,
                                            textColor: Palette.textColor.first!,
                                            currentAnimation: LottieImage.data.randomElement() ?? "")
            )
            TDetailView(
                viewModel: TDetailViewModel(title: "TiEmEo",
                                            backgroundColor: Palette.colorArray[5],
                                            textColor: Palette.textColor.first!,
                                            currentAnimation: LottieImage.data.first!)
            )
            TDetailView(
                viewModel: TDetailViewModel(title: "Fitness",
                                            backgroundColor: Palette.colorArray[8],
                                            textColor: Palette.textColor.first!,
                                            currentAnimation: LottieImage.data[3])
            )
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
