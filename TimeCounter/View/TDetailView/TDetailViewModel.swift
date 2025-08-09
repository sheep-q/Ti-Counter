//
//  TDetailViewModel.swift
//  TimeCounter
//
//  Created by nguyen.van.quangf on 18/05/2022.
//

import Foundation

class TDetailViewModel: ObservableObject {
    @Published var counter: CounterModel
    
    init(counterModel: CounterModel = CounterModel()) {
        self.counter = counterModel
    }
}
