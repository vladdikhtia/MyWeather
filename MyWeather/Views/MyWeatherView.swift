//
//  MyWeatherView.swift
//  MyWeather
//
//  Created by Vladyslav Dikhtiaruk on 20/08/2024.
//

import SwiftUI
import CoreLocation


struct MyWeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State private var isSearching = false
    @State private var searchQuery = ""
    @State var latitude: Double = 50.4504
    @State var longitude: Double = 30.5245
    
    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    var body: some View {
        NavigationStack{
            ZStack {
                RadialGradient(colors: [.blue.opacity(0.8), .purple.opacity(0.7), .pink.opacity(0.7)], center: .topLeading, startRadius: 300, endRadius: 900)
                    .ignoresSafeArea()
                
                if let data = viewModel.weather {
                    ScrollView{
                        VStack(alignment: .leading, spacing: 10) {
                            
                            Text(data.name)
                                .font(.system(size: 36, weight: .semibold, design: .serif))
                                .foregroundColor(.white)
                            
                            Divider()
                                .frame(minHeight: 2)
                                .background(Color.white)
                            
                            Text("\(data.weather[0].description.capitalized)")
                                .font(.system(size: 24, weight: .semibold, design: .serif))
                                .foregroundColor(.white)
                            
                            HStack(alignment: .top, spacing: 30) {
                                Image(systemName: "sun.max.fill")
                                    .font(.system(size: 50))
                                    .foregroundColor(.white)
                                    .offset(x: 45, y: 15)
                                
                                Text("\(data.main.temp.rounded().formatted())°")
                                    .font(.system(size: 50, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(.leading, 10)
                                    .offset(x: 45, y: 10)
                                
                                VStack(alignment: .trailing, spacing: 2) {
                                    Text("/ Real Feel")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(.white.opacity(0.8))
                                    
                                    Text("\(data.main.feels_like.rounded().formatted())°")
                                        .font(.system(size: 24, weight: .semibold))
                                        .foregroundColor(.white)
                                }
                                .offset(x: -45, y: 75)
                            }
                            .padding(.bottom, 30)
                            
                            Text("Details:")
                                .font(.system(size: 24, weight: .semibold, design: .serif))
                                .foregroundColor(.white.opacity(0.8))
                                .padding(.top, 10)
                            
                            Divider()
                                .frame(minHeight: 1)
                                .background(Color.white.opacity(0.7))
                            
                            
                            VStack(alignment: .leading, spacing: 20) {
                                HStack{
                                    Image(systemName: "wind")
                                    Text("Wind".uppercased())
                                        .font(.system(size: 16, weight: .medium))
                                    
                                    Spacer()
                                }
                                .foregroundStyle(.white.opacity(0.7))
                                
                                
                                VStack(alignment: .leading){
                                    HStack(spacing: 5){
                                        Text("\(data.wind.speed.rounded().formatted())")
                                            .font(.system(size: 32, weight: .semibold))
                                        VStack(alignment: .leading){
                                            Text("M/S")
                                                .foregroundStyle(.thinMaterial)
                                                .font(.system(size: 14, weight: .medium))
                                            Text("Wind")
                                                .font(.system(size: 14, weight: .medium))
                                        }
                                    }
                                    
                                    Divider()
                                    
                                    HStack(spacing: 5){
                                        Text(" \(data.wind.gust?.rounded().formatted() ?? "")")
                                            .font(.system(size: 32, weight: .semibold))
                                        VStack(alignment: .leading){
                                            Text("M/S")
                                                .foregroundStyle(.thinMaterial)
                                                .font(.system(size: 14, weight: .medium))
                                            Text("Gusts")
                                                .font(.system(size: 14, weight: .medium))
                                        }
                                    }
                                    
                                }
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .lineLimit(1)
                                
                            }
                            .frame(height: 140)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.thinMaterial.opacity(0.4))
                            .clipShape(.rect(cornerRadius: 20))
                            
                            LazyVGrid(columns: columns, spacing: 10) {
                                MyWeatherDetail(imageName: "mountain.2.fill", title: "ground", description: "", value: "\(data.main.grnd_level ?? 0) m")
                                MyWeatherDetail(imageName: "humidity.fill", title: "humidity", description: "", value: "\(data.main.humidity) %")
                                MyWeatherDetail(imageName: "thermometer.medium", title: "Feels Like", description: "", value: "\(data.main.feels_like.rounded().formatted())°")
                                MyWeatherDetail(imageName: "digitalcrown.press.fill", title: "pressure", description: "", value: "\(data.main.pressure) hPa")
                            }
                            .frame(maxWidth: .infinity)
                            
                            Spacer()
                        }
                        .padding()
                        
                    }
                }
                
            }            
            .toolbar(content: {
                NavigationLink {
                    SearchView(lat: $latitude, lon: $longitude)
                } label: {
                    Label("Search", systemImage: "magnifyingglass")
                    
                }
            })
            .onAppear{
                viewModel.fetchData(latitude: latitude, longitude: longitude)
            }
        }
    }
    
}

#Preview {
    MyWeatherView()
}

//struct SearchView: View {
//    @Binding var searchQuery: String
//    var onSearch: () -> Void
//
//    var body: some View {
//        VStack {
//            HStack {
//                TextField("Search location...", text: $searchQuery)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding()
//
//                Button("Search") {
//                    onSearch()
//                }
//                .padding()
//                .background(Color.blue)
//                .foregroundColor(.white)
//                .cornerRadius(8)
//            }
//            .background(Color.white.opacity(0.9))
//            .clipShape(RoundedRectangle(cornerRadius: 10))
//            .shadow(radius: 10)
//
//            Spacer()
//        }
//        .padding()
//    }
//}



