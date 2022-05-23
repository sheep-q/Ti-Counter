//
//  TodoView.swift
//  TimeCounter
//
//  Created by Quang Nguyen on 5/22/22.
//

import Foundation
import SwiftUI

struct ToDoView: View {
    @ObservedObject var viewModel = TodoViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter title", text: $viewModel.title)
                    .textFieldStyle(.roundedBorder)
                    .foregroundColor(.black)
                Picker("Priority", selection: $viewModel.selectedPriority) {
                    ForEach(Priority.allCases) { priority in
                        Text(priority.title).tag(priority)
                    }
                }.pickerStyle(.segmented)
                
                Button("Save") {
                    viewModel.appendTask()
                }
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                
                List {
                    ForEach(viewModel.allTasks.indices, id: \.self) { index in
                        VStack {
                            HStack(alignment: .center) {
                                Circle()
                                    .fill(self.viewModel.styleForPriority(viewModel.allTasks[index].priority))
                                    .frame(width: 15, height: 15)
                                Spacer().frame(width: 20)
                                Text(viewModel.allTasks[index].title)
                                    .foregroundColor(.black)
                                    .lineLimit(5)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                                
                                Image(systemName: viewModel.allTasks[index].isCheck ? "checkmark.circle.fill": "checkmark.circle")
                                    .foregroundColor(.red)
                                    .onTapGesture {
                                        viewModel.allTasks[index].isCheck.toggle()
                                        print("\(viewModel.allTasks[index].isCheck)")
                                    }
                            }
                            HStack {
                                Spacer()
                                Text(viewModel.allTasks[index].dateText)
                                    .font(.footnote.italic())
                                    .foregroundColor(.black.opacity(0.5))
                            }
                        }
                    }
                    .onDelete(perform: viewModel.deleteTask)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Take notes")
        }
    }
}
