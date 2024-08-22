//
//  WindView.swift
//  MyWeather
//
//  Created by Vladyslav Dikhtiaruk on 23/08/2024.
//

import SwiftUI

struct WindView: View {
    let wind: Double
    let gust: Double?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack{
                Image(systemName: "wind")
                Text("Wind".uppercased())
                    .font(.system(size: 16, weight: .medium))
                
                Spacer()
            }
            .foregroundStyle(.white.opacity(0.7))
            
            HStack(alignment: .center){
                HStack{
                    Text("\(wind.rounded().formatted())")
                        .font(.system(size: 32, weight: .semibold))
                    VStack(alignment: .leading){
                        Text("M/S")
                            .foregroundStyle(.white)
                            .font(.system(size: 14, weight: .medium))
                        Text("Wind")
                            .font(.system(size: 14, weight: .medium))
                    }
                }
                Spacer()
                
                if let gust = gust {
                    Spacer()
                    
                    Divider()
                    
                    Spacer()
                    
                    HStack{
                        Text(gust.rounded().formatted())
                            .font(.system(size: 32, weight: .semibold))
                        
                        VStack{
                            VStack(alignment: .leading){
                                Text("M/S")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 14, weight: .medium))
                                Text("Gusts")
                                    .font(.system(size: 14, weight: .medium))
                            }
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}


#Preview {
    WindView(wind: 1.0, gust: 1.0)
}
