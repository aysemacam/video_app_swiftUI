//
//  CustomSliderView.swift
//  video_player_app_SwiftUI
//
//  Created by Aysema Çam on 24.07.2024.
//

import SwiftUI

struct CustomSliderView: View {
    @Binding var currentTime: Double
    @Binding var duration: Double

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color.white.opacity(0.3))
                    .frame(width: geometry.size.width, height: 4)
                
                Rectangle()
                    .foregroundColor(.blue)
                    .frame(width: CGFloat((currentTime / duration) * Double(geometry.size.width)), height: 4)
            }
        }
        .cornerRadius(2)
        .disabled(true)
    }
}
