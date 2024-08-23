//
//  CityView.swift
//  MyWeather
//
//  Created by Vladyslav Dikhtiaruk on 23/08/2024.
//

import SwiftUI
import CoreLocation


struct CityView: View {
    //    let name: String
    //    let latitude: Double
    //    let longitude: Double
    let city: CityModel
    
    @State private var currentTime: String = ""
    @State private var timeZone: TimeZone?
    
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                Text(city.name)
                    .font(.title)
                
                Text(currentTime)
                    .onAppear {
                        determineTimeZone()
                    }
                
                Spacer()
                
                Text("Mostly Sunny")
            }
            
            Spacer()
            
            VStack(alignment: .center) {
                Text("25°")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
                
                HStack{
                    Text("H: 26°")
                    
                    Text("L: 11°")
                }
            }
        }
        .fontWeight(.semibold)
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(.rect(cornerRadius: 20))
        .frame(maxWidth: .infinity)
        .frame(height: 140)
        .onAppear {
            startTimer()
        }
    }
    
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 30.0, repeats: true) { _ in
            updateTime()
        }
    }
    
    func determineTimeZone() {
        let location = CLLocation(latitude: city.latitude, longitude: city.longitude)
        location.fetchTimeZone { timeZone, error in
            if let timeZone = timeZone {
                self.timeZone = timeZone
                updateTime()
            } else {
                print("DEBUG: Failed to get TimeZone: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    func updateTime() {
        guard let timeZone = timeZone else { return }
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateFormat = "HH:mm"
        currentTime = formatter.string(from: Date())
    }
    
}

#Preview {
    CityView(city: CityModel(name: "Cherkasy", longitude: 21.32, latitude: 41.54))
}

extension CLLocation {
    func fetchTimeZone(completion: @escaping (TimeZone?, Error?) -> Void) {
        CLGeocoder().reverseGeocodeLocation(self) { placemarks, error in
            completion(placemarks?.first?.timeZone, error)
        }
    }
}
