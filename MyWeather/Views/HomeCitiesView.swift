//
//  CitiesView.swift
//  MyWeather
//
//  Created by Vladyslav Dikhtiaruk on 22/08/2024.
//

import SwiftUI
import CoreLocation
import SwiftData

struct HomeCitiesView: View {
    @StateObject private var viewModel: WeatherViewModel
    @State private var navigationPath = NavigationPath()
    
    
    init(networkManager: NetworkProtocol, storageManager: StorageProtocol){
        _viewModel = StateObject(wrappedValue: WeatherViewModel(networkManager: networkManager, storageManager: storageManager))
    }
    
    @State private var coordinates: CLLocationCoordinate2D?
    @State private var locationName = ""
    @State private var isLoading = false
    @State private var errorMessage: String?
    
    @State var lat: Double? = nil
    @State var lon: Double? = nil
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            List{
                ForEach(viewModel.cities){ city in
                    Button {
                        navigationPath.append(city)
                    } label: {
                        CityView(city: city)
                    }
                }
                .onDelete(perform: viewModel.deleteCityFromDB)
            }
            .navigationDestination(for: CityModel.self) { city in
                MyWeatherSearchedView(
                    viewModel: viewModel,
                    latitude: city.latitude,
                    longitude: city.longitude,
                    navigationPath: $navigationPath
                )
            }
            .listStyle(.plain)
            //            .searchable(text: $search, prompt: "Search for a city")
            .toolbar{
                NavigationLink(value: "search") {
                    Label(
                        "Add city",
                        systemImage: "plus"
                    )
                    .buttonRepeatBehavior(.disabled)
                }
                .navigationDestination(for: String.self) { value in
                    if value == "search" {
                        SearchView(
                            viewModel: viewModel,
                            navigationPath: $navigationPath,
                            lat: $lat,
                            lon: $lon
                        )
                    }
                }
            }
            .navigationTitle("MyWeather")
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    HomeCitiesView(networkManager: MockNetworkManager(), storageManager: MockStorageManager())
}
