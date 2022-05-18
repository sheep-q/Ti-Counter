//
//  LottieView.swift
//  TimeCounter
//
//  Created by nguyen.van.quangf on 17/05/2022.
//

import Foundation
import SwiftUI
import Lottie

enum ProgresKeyFrames: CGFloat {
    case start = 140
    case end = 1
}

struct LottieView: UIViewRepresentable {
    var name = "105188-berry-the-old-man"
    var loopMode: LottieLoopMode = .loop
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
        
        let animationView = AnimationView()
        let animation = Animation.named(name)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.play()
        animationView.play { _ in
            pauseProgress()
        }
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        func pauseProgress() {
            animationView.play(fromProgress: 0, toProgress: 0.75, loopMode: .playOnce, completion: nil)
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
