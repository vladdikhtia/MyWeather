//
//  MyWeatherView.swift
//  MyWeather
//
//  Created by Vladyslav Dikhtiaruk on 20/08/2024.
//

import SwiftUI
import SwiftData


struct MyWeatherMainView: View {
    @ObservedObject var viewModel: WeatherViewModel
    @Binding var navigationPath: NavigationPath
    @Binding var lat: Double?
    @Binding var lon: Double?
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack{
            WeatherView(viewModel: viewModel)
                .toolbar{
                    ToolbarItem(placement: .topBarLeading) {
                        Button(role: .cancel) {
                            dismiss()
                        } label: {
                            Label("Cancel", systemImage: "xmark.circle")
                                .labelStyle(.titleOnly)
                        }
                        .tint(.white)
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(role: .destructive) {
                            if let data = viewModel.weather {
                                if viewModel.cities.contains(where: { $0.name == data.name } ) {
                                    print("You already have this in your collection!")
                                } else {
                                    viewModel.addCityToDB(
                                        cityName: data.name,
                                        cityLongitude: data.coord.lon ,
                                        cityLatitude: data.coord.lat
                                    )
                                    print("City successfully added to DB!")
                                }
                                // go to HomeCitiesScreen
                                navigationPath.removeLast(navigationPath.count)
                            }
                        } label: {
                            Label("Add", systemImage: "plus.circle")
                                .labelStyle(.titleOnly)
                        }
                        .tint(.white)
                        .fontWeight(.bold)
                    }
                }
        }
        .onAppear{
            viewModel.fetchWeather(latitude: lat ?? 0, longitude: lon ?? 0)
        }
    }
}


#Preview {
    MyWeatherMainView(
        viewModel: WeatherViewModel(networkManager: MockNetworkManager(), storageManager: MockStorageManager()),
        navigationPath: .constant(NavigationPath()),
        lat: .constant(50.021),
        lon: .constant(30.031)
    )
}





