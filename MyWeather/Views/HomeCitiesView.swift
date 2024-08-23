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
    @Query var cities: [CityModel]
    @Environment(\.modelContext) var modelContext

    
    @State private var coordinates: CLLocationCoordinate2D?
    @State private var locationName = ""
    @State private var isLoading = false
    @State private var errorMessage: String?
    
    @State var lat: Double? = nil
    @State var lon: Double? = nil
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(cities){ city in
                  CityView(city: city)
                }
                .onDelete(perform: deleteCity)
            }
            .listStyle(.plain)
//            .searchable(text: $search, prompt: "Search for a city")
            .toolbar{
                NavigationLink {
                   SearchView(lat: $lat, lon: $lon)
                } label: {
                    Label("Add city", systemImage: "plus")
                        .buttonRepeatBehavior(.disabled)
                }
            }
            .navigationTitle("MyWeather")
            .preferredColorScheme(.dark)
        }
    }
    
    func addSamples() {
        let rome = CityModel(name: "Rome", longitude: 21.54, latitude: 43.32)
        let florence = CityModel(name: "Florence", longitude: 21.54, latitude: 43.32)
        let milano = CityModel(name: "Milano", longitude: 21.54, latitude: 43.32)
        
        modelContext.insert(rome)
        modelContext.insert(florence)
        modelContext.insert(milano)
    }
    
    func deleteCity(_ indexSet: IndexSet) {
        for index in indexSet {
            let city = cities[index]
            modelContext.delete(city)
        }
    }
}

#Preview {
    HomeCitiesView()
}
