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
    
    @Binding var lat: Double
    @Binding var lon: Double
    
    var body: some View {
        VStack {
            TextField("Enter location", text: $locationName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Get Coordinates") {
                fetchCoordinates(for: locationName)
            }
            .padding()
            .disabled(isLoading)
            
            if isLoading {
                ProgressView()
            }
            
            if let coordinates = coordinates {
                Text("Latitude: \(coordinates.latitude)")
                Text("Longitude: \(coordinates.longitude)")
            } else if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
        }
        .padding()
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
            } else {
                errorMessage = "No coordinates found"
            }
        }
    }
}


#Preview {
    SearchView(lat: .constant(213.2), lon: .constant(32.2))
}
