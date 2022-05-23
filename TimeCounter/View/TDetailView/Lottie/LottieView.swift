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
    var name = "87082-love-heart"
    var lastName = ""
    var loopMode: LottieLoopMode = .playOnce
    var animationView = AnimationView()
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> some UIView {
        
        let view = UIView()
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<LottieView>) {
        guard lastName != name else {
            return
        }
        uiView.subviews.forEach({$0.removeFromSuperview()})
        
        animationView.animation = Animation.named(name)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        uiView.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: uiView.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: uiView.widthAnchor)
        ])
        animationView.loopMode = .repeat(2)
        animationView.play { _ in
            pauseProgress()
           
        }
    }
    
    func pauseProgress() {
        animationView.play(fromProgress: 0, toProgress: 0.75, loopMode: .playOnce, completion: nil)
    }
}
