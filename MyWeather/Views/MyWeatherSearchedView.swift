//
//  MyWeatherSearchedView.swift
//  MyWeather
//
//  Created by Vladyslav Dikhtiaruk on 25/08/2024.
//

import SwiftUI

struct MyWeatherSearchedView: View {
    @ObservedObject var viewModel: WeatherViewModel
    var latitude: Double
    var longitude: Double
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        WeatherView(viewModel: viewModel)
            .onAppear{
                viewModel.fetchWeather(latitude: latitude, longitude: longitude)
            }
    }
}


#Preview {
    MyWeatherSearchedView(viewModel: WeatherViewModel(networkManager: MockNetworkManager(), storageManager: MockStorageManager()), latitude: 50, longitude: 30, navigationPath: .constant(NavigationPath()))
}
