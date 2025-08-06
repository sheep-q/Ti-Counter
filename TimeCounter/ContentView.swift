//
//  ContentView.swift
//  TimeCounter
//
//  Created by nguyen.van.quangf on 17/05/2022.
//

import SwiftUI

struct ContentView: View {
    
    private var key = "dataUserDefault"
    @State var dataList: [TDetailViewModel]
    
    init() {
        var data = [TDetailViewModel]()
        
        do {
            let value = try UserDefaults.standard.getObject(forKey: key, castTo: [TDetailViewModel].self)
            data = value
        } catch {
            print(error.localizedDescription)
        }
        self.dataList = data
    }
    
    var body: some View {
        TabView {
            ForEach (dataList) { data in
                TDetailView(viewModel: data)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .background(.black)
        .ignoresSafeArea()
        .onAppear {
            dataList = getMockData()
        }
        .onDisappear {
            saveUserDefaultData()
        }
    }
    
    func saveUserDefaultData() {
        do {
            UserDefaults.standard.removeObject(forKey: key)
            try UserDefaults.standard.setObject(dataList, forKey: key)
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    private func getMockData() -> [TDetailViewModel] {
        var data = [TDetailViewModel]()
        
        data.append(TDetailViewModel(title: "Orthodontics",
                                     backgroundColor: Palette.colorArray.first!,
                                     textColor: Palette.textColor.first!,
                                     currentAnimation: LottieImage.data.randomElement() ?? ""))
        data.append(TDetailViewModel(title: "TiEmEo",
                                     backgroundColor: Palette.colorArray[5],
                                     textColor: Palette.textColor.first!,
                                     currentAnimation: LottieImage.data.first!))

        data.append(TDetailViewModel(title: "Fitness",
                                                backgroundColor: Palette.colorArray[8],
                                                textColor: Palette.textColor.first!,
                                                currentAnimation: LottieImage.data[3]))
        return data
    }
    
    func saveMoc() {
        var data = [TDetailViewModel]()
        
        data.append(TDetailViewModel(title: "Orthodontics",
                                     backgroundColor: Palette.colorArray.first!,
                                     textColor: Palette.textColor.first!,
                                     currentAnimation: LottieImage.data.randomElement() ?? ""))
        data.append(TDetailViewModel(title: "TiEmEo",
                                     backgroundColor: Palette.colorArray[5],
                                     textColor: Palette.textColor.first!,
                                     currentAnimation: LottieImage.data.first!))

        data.append(TDetailViewModel(title: "Fitness",
                                                backgroundColor: Palette.colorArray[8],
                                                textColor: Palette.textColor.first!,
                                                currentAnimation: LottieImage.data[3]))
        do {
            try UserDefaults.standard.setObject(data, forKey: key)
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
