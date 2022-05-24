//
//  TakeNoteView.swift
//  TimeCounter
//
//  Created by nguyen.van.quangf on 24/05/2022.
//

import SwiftUI

struct TakeNoteView: View {
    @ObservedObject var viewModel: TodoViewModel
    
    init(viewModel: TodoViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        List {
            ForEach(viewModel.allTasks) { task in
                VStack {
                    Text("• " + task.title)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .listRowSeparator(.hidden)
            }
            .listRowBackground(Color.clear)
        }
        .listStyle(PlainListStyle())
    }
}
