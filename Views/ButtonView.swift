//
//  ButtonView.swift
//  A1Apps Assignment
//
//  Created by Mohamed Ameen on 20/09/25.
//

import SwiftUI

struct ShopButton: View {
    var body: some View {
        Button(action: {
            // Add action here
            print("Shop tapped")
        }) {
            Text("Shop")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .padding(.horizontal, 15)
                .padding(.vertical, 5)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.red, Color.black.opacity(0.8)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .clipShape(Capsule())
                .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
        }
    }
}
