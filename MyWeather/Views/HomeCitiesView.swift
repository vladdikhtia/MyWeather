//
//  CitiesView.swift
//  MyWeather
//
//  Created by Vladyslav Dikhtiaruk on 22/08/2024.
//

import SwiftUI
import CoreLocation

struct HomeCitiesView: View {
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
}

#Preview {
    HomeCitiesView()
}
