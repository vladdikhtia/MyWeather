//
//  WeatherView.swift
//  MyWeather
//
//  Created by Vladyslav Dikhtiaruk on 26/08/2024.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel
    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]

    var body: some View {
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
                        MyWeatherDetailInfo(imageName: "thermometer.medium", title: "Feels Like", description: "", value: "\(data.main.feels_like.rounded().formatted())°")
                        MyWeatherDetailInfo(imageName: "humidity.fill", title: "humidity", description: "", value: "\(data.main.humidity) %")
                        MyWeatherDetailInfo(imageName: "mountain.2.fill", title: "ground", description: "", value: "\(data.main.grnd_level ?? 0) m")
                        MyWeatherDetailInfo(imageName: "gauge.with.dots.needle.bottom.50percent", title: "pressure", description: "", value: "\(data.main.pressure) hPa")
                    }
                    
                    // add data provided by ....
                    
                }
                .padding()
            } else {
                ProgressView()
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

#Preview {
    WeatherView(viewModel: WeatherViewModel(networkManager: MockNetworkManager(), storageManager: MockStorageManager()))
}
