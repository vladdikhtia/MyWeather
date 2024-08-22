//
//  CitiesView.swift
//  MyWeather
//
//  Created by Vladyslav Dikhtiaruk on 22/08/2024.
//

import SwiftUI
import CoreLocation

struct HomeCitiesView: View {
    let gradient = RadialGradient(colors: [.blue.opacity(0.8), .purple.opacity(0.7), .pink.opacity(0.7)], center: .topLeading, startRadius: 300, endRadius: 900)
    
    @State private var coordinates: CLLocationCoordinate2D?
    @State private var locationName = ""
    @State private var isLoading = false
    @State private var errorMessage: String?
    
    @State var lat: Double? = nil
    @State var lon: Double? = nil
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(0 ..< 15) { item in
                    VStack{
                        Text("\(item)")
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .background(.yellow)
                    .clipShape(.rect(cornerRadius: 12))
                    .padding()
                }
            }
//            .searchable(text: $search, prompt: "Search for a city")
//            VStack{
//                TextField("Search for a city", text: $locationName)
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .frame(height: 58)
//                    .background(.primary.opacity(0.4))
//                    .clipShape(.rect(cornerRadius: 12))
//                    .padding()
//                    .onSubmit {
//                        fetchCoordinates(for: locationName)
//                    }
//                
//                NavigationLink {
//                    MyWeatherView(lat: $lat, lon: $lon)
//                } label: {
//                    Text("Get weather")
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .frame(height: 58)
//                        .foregroundStyle(.white)
//                        .background(.green.opacity(0.7))
//                        .clipShape(.rect(cornerRadius: 12))
//                        .padding()
//                }
//                .disabled(isLoading)
//                
//                if isLoading {
//                    ProgressView()
//                }
//                
//                Spacer()
//            }
            .toolbar(content: {
                NavigationLink {
                   SearchView(lat: $lat, lon: $lon)
                } label: {
                    Label("Add city", systemImage: "plus")
                }
                
            })
            .navigationTitle("MyWeather")
            .preferredColorScheme(.dark)
        }
        
        
    }
    
    func fetchCoordinates(for locationName: String) {
        isLoading = true
        errorMessage = nil
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(locationName) { placemarks, error in
            isLoading = false
            
            if let error = error {
                errorMessage = "Error: \(error.localizedDescription)"
                return
            }
            
            if let placemark = placemarks?.first, let location = placemark.location {
                coordinates = location.coordinate
                self.lat = coordinates?.latitude ?? 0
                self.lon = coordinates?.longitude ?? 0
                print("Good")
            } else {
                errorMessage = "No coordinates found"
            }
        }
    }
}

#Preview {
    HomeCitiesView()
}
