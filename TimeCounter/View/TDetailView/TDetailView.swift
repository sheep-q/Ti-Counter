//
//  TDetailView.swift
//  TimeCounter
//
//  Created by nguyen.van.quangf on 18/05/2022.
//

import Lottie
import SwiftUI

struct TDetailView: View {
    @ObservedObject var viewModel = TDetailViewModel()
    @State private var pickDate = Date()
    @State private var isShowNote = false
    @State private var image = UIImage()
    @State private var isShowImageSheet = false
    @State private var isChooseImage = false
    @State private var isEditing = false

    init(viewModel: TDetailViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        containerView
    }

    @ViewBuilder
    var containerView: some View {
        ZStack {
            Color(hex: viewModel.counter.backgroundColor)
                .ignoresSafeArea()
            
            contentView

            VStack {
                Spacer()
                toolView
                    .padding(.bottom, 20)
            }
            .padding(.leading, 30)
            .padding(.trailing, 15)
        }
        .foregroundColor(Color(hex: viewModel.counter.textCorlor))
    }
    
    @ViewBuilder
    var contentView: some View {
        ScrollView {
            ZStack {
                // Lottie animation View + Take note View
                VStack(alignment: .leading) {
                    DetailHeaderView(viewModel: viewModel, pickDate: $pickDate)
                        .padding(.bottom, Device.height > 680 ? 45 : 15)
                        .padding(.leading, 30)
                        .padding(.trailing, 15)

                    ZStack(alignment: .top) {
                        HStack {
                            Spacer()
                            GeometryReader { geometry in
                                LottieView(animation: .named(viewModel.counter.lottieImage))
                                    .playing(loopMode: .loop)
                                    .frame(
                                        width: geometry.size.width, height: geometry.size.height
                                    )
                                    .offset(x: 40)
                            }
                        }

                        HStack(alignment: .top) {
                            TimerView(
                                dateComponent: viewModel.counter.dateComponents,
                                referenceDate: pickDate,
                                countType: viewModel.counter.countType
                            )
                            .padding(.bottom, 10)

                            Spacer()
                            addImageButton
                        }
                        .padding(.leading, 30)
                        .padding(.trailing, 15)

                    }
                    // Button + Take note view
                    VStack(alignment: .leading) {
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
                                    .opacity(0.2)
                            }
                        }
                        .sheet(isPresented: $isShowNote) {
                            ToDoView(viewModel: viewModel.counter.todoViewModel)
                        }

                        TakeNoteView(viewModel: viewModel.counter.todoViewModel)
                    }
                    .padding(.leading, 30)
                    .padding(.trailing, 15)
                }
            }
        }
    }

    @ViewBuilder
    var addImageButton: some View {
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
                    .opacity(0.2)
            }
        }
        .sheet(isPresented: $isShowImageSheet) {
            // dismiss
            isChooseImage = true
        } content: {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
        }
        .onChange(of: image) { newValue in
            isChooseImage = true
        }
    }

    @ViewBuilder
    var toolView: some View {
        VStack(alignment: .trailing) {
            HStack {
                Spacer()
                Button {
                    withAnimation {
                        isEditing.toggle()
                    }
                } label: {
                    Image(systemName: "paintpalette")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(8)
                        .background(.ultraThinMaterial.opacity(isEditing ? 1 : 0.5))
                        .cornerRadius(12)
                }
            }
            
            if isEditing {
                PickColorView(
                    isText: true,
                    currentColor: viewModel.counter.backgroundColor,
                    currentTextColor: viewModel.counter.textCorlor
                ) { value in
                    viewModel.counter.textCorlor = value
                }
                
                PickColorView(
                    isText: false,
                    currentColor: viewModel.counter.backgroundColor,
                    currentTextColor: viewModel.counter.textCorlor
                ) { value in
                    viewModel.counter.backgroundColor = value
                }
                
                PickAnimationView(currenAnimation: viewModel.counter.lottieImage) { value in
                    guard viewModel.counter.lottieImage != value else {
                        return
                    }
                    viewModel.counter.lottieImage = value
                }
            }
        }
    }
}

struct TDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TDetailView(viewModel: TDetailViewModel())
    }
}
