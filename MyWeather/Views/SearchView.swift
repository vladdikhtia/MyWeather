//
//  SearchView.swift
//  MyWeather
//
//  Created by Vladyslav Dikhtiaruk on 20/08/2024.
//

import SwiftUI
import CoreLocation

struct SearchView: View {
    @State private var coordinates: CLLocationCoordinate2D?
    @State private var locationName = ""
    @State private var isLoading = false
    @State private var errorMessage: String?
    
    @Binding var lat: Double?
    @Binding var lon: Double?
    @State private var isPresented = false
    
    var body: some View {
        VStack{
            TextField("Search for a city", text: $locationName)
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 58)
                .background(.primary.opacity(0.4))
                .clipShape(.rect(cornerRadius: 12))
                .padding()
                .onSubmit {
                    fetchCoordinates(for: locationName)
                }

            Button {
                isPresented = true
            } label: {
                Text("Get weather")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 58)
                    .foregroundStyle(.white)
                    .background(.green.opacity(0.7))
                    .clipShape(.rect(cornerRadius: 12))
                    .padding()
            }
            .disabled(isLoading)
            
            if isLoading {
                ProgressView()
            }
            
            Spacer()
        }
        .sheet(isPresented: $isPresented){
            MyWeatherMainView(lat: $lat, lon: $lon, isPresented: $isPresented)
        }
    }
    
    private func fetchCoordinates(for locationName: String) {
        isLoading = true
        errorMessage = nil
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(locationName) { placemarks, error in
            isLoading = false
            
            if let error = error {
                errorMessage = "Error: \(error.localizedDescription)"
                print("\(errorMessage?.description ?? "error")")
                return
            }
            
            if let placemark = placemarks?.first, let location = placemark.location {
                coordinates = location.coordinate
                self.lat = coordinates?.latitude ?? 0
                self.lon = coordinates?.longitude ?? 0
            } else {
                errorMessage = "No coordinates found"
                print("\(errorMessage?.description ?? "error")")
            }
        }
    }
}


#Preview {
    NavigationStack{
        SearchView(lat: .constant(213.2), lon: .constant(32.2))
    }
    
}
