//
//  MyWeatherView.swift
//  MyWeather
//
//  Created by Vladyslav Dikhtiaruk on 20/08/2024.
//

import SwiftUI
import CoreLocation
import SwiftData



struct MyWeatherMainView: View {
    @ObservedObject var viewModel: WeatherViewModel

    @Binding var navigationPath: NavigationPath
    @Binding var lat: Double?
    @Binding var lon: Double?
    @Binding var isPresented: Bool
    @State private var cityName: String? = nil

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
                            
                            Image(systemName: getWeatherIcon(for: data.weather[0].main.lowercased()))
                                .font(.system(size: 50))
                                .foregroundColor(.white)
                                .offset(x: 45, y: 15)
                            if data.weather[0].main.lowercased().contains("rain") {
                                ZStack {
                                    ForEach(0..<20) { index in
                                        RaindropAnimation()
                                            .offset(x: CGFloat.random(in: -UIScreen.main.bounds.width/2...UIScreen.main.bounds.width/2))
                                    }
                                }
                            }
                            
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
                        
                        WindView(wind: data.wind.speed, gust: data.wind.gust)
                            .frame(maxHeight: 100)
                            .padding()
                            .background(.thinMaterial.opacity(0.4))
                            .clipShape(.rect(cornerRadius: 20))
                        
                        LazyVGrid(columns: columns, spacing: 10) {
                            MyWeatherDetail(imageName: "thermometer.medium", title: "Feels Like", description: "", value: "\(data.main.feels_like.rounded().formatted())°")
                            MyWeatherDetail(imageName: "humidity.fill", title: "humidity", description: "", value: "\(data.main.humidity) %")
                            MyWeatherDetail(imageName: "mountain.2.fill", title: "ground", description: "", value: "\(data.main.grnd_level ?? 0) m")
                            MyWeatherDetail(imageName: "gauge.with.dots.needle.bottom.50percent", title: "pressure", description: "", value: "\(data.main.pressure) hPa")
                        }
                        
                        // add data provided by ....
                        
                    }
                    .padding()
                    .toolbar(content: {
                        ToolbarItem(placement: .topBarLeading) {
                            Button(role: .cancel) {
                                isPresented = false
                            } label: {
                                Label("Cancel", systemImage: "xmark.circle")
                                    .labelStyle(.titleOnly)
                            }
                            .tint(.white)
                        }
                        
                        ToolbarItem(placement: .topBarTrailing) {
                            Button(role: .destructive) {
                                if viewModel.cities.contains(where: { $0.name == data.name } ) {
                                    print("You already have this in your collection!")
                                } else {
                                    viewModel.addCityToDB(cityName: data.name, cityLongitude: data.coord.lon , cityLatitude: data.coord.lat)
                                    print("City successfully added to DB!")
                                }
                               
                                // go to HomeCitiesScreen
                                navigationPath.removeLast(navigationPath.count)

                            } label: {
                                Label("Add", systemImage: "plus.circle")
                                    .labelStyle(.titleOnly)
                            }
                            .tint(.white)
                            .fontWeight(.bold)
                        }
                    })
                } else {
                    ProgressView()
                }
                
            }
            .onAppear{
                viewModel.fetchWeather(latitude: lat ?? 0, longitude: lon ?? 0)
            }
        }
    }
    private func getWeatherIcon(for condition: String) -> String {
        switch condition {
        case _ where condition.contains("sun"):
            return "sun.max.fill"
        case _ where condition.contains("clouds"):
            return "cloud.fill"
        case _ where condition.contains("rain"):
            return "cloud.rain.fill"
        case _ where condition.contains("snow"):
            return "cloud.snow.fill"
        default:
            return "sun.max.fill"
        }
    }
}


//#Preview {
//    let container = ModelContainer(for: CityModel.self)
//    MyWeatherMainView(viewModel: WeatherViewModel(networkManager: NetworkServiceManager(), storageManager: StorageServiceManager(modelContext: container.mainContext)), lat: .constant(20.01), lon: .constant(43.01), isPresented: .constant(true))
//}




