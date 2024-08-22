//
//  RaindropAnimation.swift
//  MyWeather
//
//  Created by Vladyslav Dikhtiaruk on 23/08/2024.
//

import SwiftUI

struct RaindropAnimation: View {
    @State private var offsetY: CGFloat = -150
    
    var body: some View {
        Circle()
            .fill(Color.blue.opacity(0.8))
            .frame(width: CGFloat(integerLiteral: Int.random(in: 3...8)), height: CGFloat(integerLiteral: Int.random(in: 8...15)))
            .offset(y: offsetY)
            .onAppear {
                withAnimation(
                    .linear(duration: Double.random(in: 1.0...3.0))
                    .repeatForever(autoreverses: false)
                ) {
                    offsetY = UIScreen.main.bounds.height - 700
                }
            }
    }
}


#Preview {
    RaindropAnimation()
}
