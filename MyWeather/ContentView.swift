//
//  ContentView.swift
//  MyWeather
//
//  Created by Vladyslav Dikhtiaruk on 20/08/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = WeatherViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear{
            vm.fetchData(latitude: 50.4504, longitude: 30.5245)
        }
    }
}

#Preview {
    ContentView()
}
