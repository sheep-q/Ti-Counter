//
//  TDetailView.swift
//  TimeCounter
//
//  Created by nguyen.van.quangf on 18/05/2022.
//

import SwiftUI
import Lottie

let buttonOpacity: CGFloat = 0.2

struct TDetailView: View {
    @ObservedObject var viewModel = TDetailViewModel()
    @State private var pickDate = Date()
    @State private var changeTitle = false
    @State private var isShowNote = false
    @State private var image = UIImage()
    @State private var isShowImageSheet = false
    @State private var isChooseImage = false
    @State private var title = ""
    
    init (viewModel: TDetailViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        ZStack {
            Color(hex: viewModel.backgroundColor)
                .ignoresSafeArea()
            
            GeometryReader { proxy in
                ZStack {
                    // Image view
                    HStack {
                        Spacer()
                        Image(uiImage: self.image)
                            .resizable()
                            .scaledToFill()
                            .cornerRadius(20)
                            .frame(width: proxy.size.width / 2, height: proxy.size.width / 2)
                            .background(Color.clear)
                            .aspectRatio(contentMode: .fill)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding(.trailing, 35)
                            .offset(y: -35)
                    }
                    // Lottie animation View + Take note View
                    VStack(alignment: .leading) {
                        headerView
                            .padding(.bottom, proxy.size.height > 680 ? 45 : 15)
                        
                        ZStack(alignment: .top) {
                            LottieView(animation: .named(viewModel.currentAnimation))
                                .playing(loopMode: .loop)
                            
                            .frame(height: proxy.size.height / 2)
                            .offset(x: proxy.size.width / 8, y: -proxy.size.width / 8)
                            .scaleEffect(1.2)
                            .padding(.bottom, 0)
                            
                            HStack(alignment: .top) {
                                TimerView(dateComponent: viewModel.dateComponents,
                                          referenceDate: pickDate,
                                          countkind: viewModel.currentKindCount)
                                .padding(.bottom, 10)
                                
                                Spacer()
                                Button {
                                    isShowImageSheet = true
                                } label: {
                                    HStack {
                                        Image(systemName: "photo.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 20, height: 20)
                                    }
                                    .padding(8)
                                    .background {
                                        RoundedRectangle(cornerRadius: 7)
                                            .fill(.ultraThinMaterial)
                                            .opacity(buttonOpacity)
                                    }
                                }
                                .sheet(isPresented: $isShowImageSheet) {
                                    // dismiss
                                    isChooseImage = true
                                    viewModel.lastAnimation = "trick to reload animation when change slide"
                                } content: {
                                    ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                                }
                                .onChange(of: image) { newValue in
                                    isChooseImage = true
                                }
                            }
                            
                        }
                        // Button + Take note view
                        VStack {
                            HStack {
                                Button {
                                    isShowNote = true
                                } label: {
                                    HStack {
                                        Image(systemName: "square.and.pencil")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 20, height: 20)
                                        Spacer().frame(width: 8)
                                        Image(systemName: "bell.circle")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 20, height: 20)
                                    }
                                    .padding(8)
                                    .background {
                                        RoundedRectangle(cornerRadius: 7)
                                            .fill(.ultraThinMaterial)
                                            .opacity(buttonOpacity)
                                    }
                                }
                                .sheet(isPresented: $isShowNote) {
                                    ToDoView(viewModel: viewModel.todoViewModel)
                                }
                            }
                            .frame(maxWidth: .infinity ,alignment: .trailing)
                            
                            TakeNoteView(viewModel: viewModel.todoViewModel)
                                .padding(.leading, -15)
                                .padding(.trailing, 30)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .offset(y: -proxy.size.width / 5)
                        .padding(.bottom, -proxy.size.width / 5)
                    }
                    
                    VStack {
                        Spacer()
                        toolView
                            .padding(.bottom, 20)
                    }
                }
                .padding(.leading, 30)
                .padding(.trailing, 15)
            }
        }
        // trick to reload animation when change slide
        .onAppear(perform: {
            viewModel.lastAnimation = "trick to reload animation when change slide"
        })
        .foregroundColor(Color(hex: viewModel.textCorlor))
    }
    
    @ViewBuilder
    var headerView: some View {
        VStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 7).frame(width: 100, height: 1)
                .padding(.top, 5)
            
            VStack(alignment: .leading, spacing: 0) {
                Button {
                    changeTitle.toggle()
                } label: {
                    Image(systemName: "pencil.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.ultraThinMaterial)
                        .frame(width: 20, height: 20)
                }
                
                if changeTitle {
                    TextField("Title of Ti-Count", text: $viewModel.title)
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 40))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundColor(.gray)
                        .background(.clear)
                        .frame(maxWidth: 250, alignment: .leading)
                } else {
                    Text(viewModel.title)
                        .font(.system(size: 40))
                        .fontWeight(.semibold)
                        .lineLimit(2)
                        .frame(maxWidth: 250, alignment: .leading)
                }
            }
            
            HStack(alignment: .center) {
                Menu {
                    Button(CountKinds.increase.rawValue, action: viewModel.increaseKind)
                    Button(CountKinds.down.rawValue, action: viewModel.downKind)
                } label: {
                    Text(viewModel.currentKindCount.rawValue)
                        .font(.body)
                        .padding(7)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.ultraThinMaterial)
                                .opacity(buttonOpacity)
                        }
                }
                
                DatePicker(selection: $pickDate, displayedComponents: [.date, .hourAndMinute]) {}
                    .labelsHidden()
                    .colorScheme(.light)
                    .colorInvert()
            }
            .padding(.top, -15)
            .padding(.bottom, 0)
            
            dividedView
        }
        .frame(maxWidth: .infinity ,alignment: .leading)
    }
    
    @ViewBuilder
    var dividedView: some View {
        HStack {
            RoundedRectangle(cornerRadius: 7)
                .frame(width: 50, height: 0.5)
            Spacer()
            RoundedRectangle(cornerRadius: 7)
                .frame(width: 150, height: 1)
            Spacer()
        }
        .padding(.vertical, 0)
    }
    
    @ViewBuilder
    var toolView: some View {
        VStack(alignment: .trailing) {
            PickColorView(isText: true,
                          currentColor: viewModel.backgroundColor,
                          currentTextColor: viewModel.textCorlor
            ) { value in
                viewModel.textCorlor = value
            }
            
            PickColorView(
                isText: false,
                currentColor: viewModel.backgroundColor,
                currentTextColor: viewModel.textCorlor
            ) { value in
                viewModel.backgroundColor = value
            }
            
            PickAnimationView(currenAnimation: viewModel.currentAnimation) { value in
                guard viewModel.currentAnimation != value else {
                    return
                }
                viewModel.lastAnimation = viewModel.currentAnimation
                viewModel.currentAnimation = value
            }
        }
    }
}

struct TDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TDetailView(viewModel: TDetailViewModel())
    }
}
