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
    
    init(viewModel: TodoViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                TextField("Enter title", text: $viewModel.title)
                    .textFieldStyle(.roundedBorder)
                    .foregroundColor(.black)
                Picker("Priority", selection: $viewModel.selectedPriority) {
                    ForEach(Priority.allCases) { priority in
                        Text(priority.title).tag(priority)
                            .font(.body)
                    }
                }.pickerStyle(.segmented)
                
                HStack(spacing: 15) {
                    Toggle(isOn: $viewModel.isNoti) {
                        DatePicker(selection: $viewModel.notiDate, displayedComponents: [.date, .hourAndMinute]) {
                            Text("Notification")
                                .font(.body)
                                .foregroundColor(Color(hex: Palette.gray))
                        }
                        .colorScheme(.dark)
                        .colorInvert()
                    }
                }
                
                Button("Save") {
                    viewModel.appendTask()
                }
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(self.viewModel.styleForPriority(viewModel.selectedPriority.title))
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                
                List {
                    ForEach(viewModel.allTasks.indices, id: \.self) { index in
                        VStack {
                            HStack(alignment: .center) {
                                Circle()
                                    .fill(self.viewModel.styleForPriority(viewModel.allTasks[index].priority))
                                    .frame(width: 15, height: 15)
                                
                                Text(viewModel.allTasks[index].title)
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.leading)
                                    .fixedSize(horizontal: false, vertical: true)
                                
                                
                                Spacer()
                                
                                Image(systemName: viewModel.allTasks[index].isCheck ? "checkmark.circle.fill": "checkmark.circle")
                                    .foregroundColor(.pink)
                                    .onTapGesture {
                                        viewModel.toggleCheck(index: index)
                                        print("\(viewModel.allTasks[index].isCheck)")
                                    }
                            }
                            
                            if viewModel.allTasks[index].isNoti {
                                HStack {
                                    Image(systemName: "bell.circle")
                                        .resizable().scaledToFit()
                                        .frame(width: 15, height: 15)
                                        .foregroundColor(.pink)
                                    
                                    Text(viewModel.allTasks[index].dateNotiString)
                                        .font(.footnote)
                                        .foregroundColor(.black.opacity(0.5))
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            
                            
                            HStack {
                                Text(viewModel.allTasks[index].dateCreatedString)
                                    .font(.footnote.italic())
                                    .foregroundColor(.black.opacity(0.5))
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                    .onDelete(perform: viewModel.deleteTask)
                }
                .listStyle(PlainListStyle())
                
                Spacer()
            }
            .padding(20)
            .navigationTitle("Take notes")
        }
    }
}
