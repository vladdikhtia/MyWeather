//
//  MyWeatherDetail.swift
//  MyWeather
//
//  Created by Vladyslav Dikhtiaruk on 20/08/2024.
//

import SwiftUI

struct MyWeatherDetail: View {
    var imageName: String
    var title: String
    var description: String
    var value: String
    
    var body: some View {
        VStack(spacing: 20) {
            HStack{
                Image(systemName: imageName)
                Text(title.uppercased())
                    .font(.system(size: 16, weight: .medium))

                Spacer()
            }
            .foregroundStyle(.white.opacity(0.7))
            
            
            VStack(alignment: .leading){
                Text("\(value)")
                    .font(.system(size: 28, weight: .semibold))
                
                Spacer()
                
                Text(description)
                    .font(.system(size: 15, weight: .regular , design: .default))
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .lineLimit(1)

        }
        .frame(height: 120)
        .frame(maxWidth: .infinity)
        .padding()
        .background(.thinMaterial.opacity(0.4))
        .clipShape(.rect(cornerRadius: 20))
    }
}

#Preview {
    MyWeatherDetail(imageName: "eye.fill", title: "Visibility", description: "Perfectly clear view.", value: "27")
}
