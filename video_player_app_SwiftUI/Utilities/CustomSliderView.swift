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
    var onSliderChange: (Double) -> Void

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
             
                Rectangle()
                    .foregroundColor(Color.clear)
                    .contentShape(Rectangle())
                    .gesture(DragGesture(minimumDistance: 0)
                                .onChanged { value in
                                    let sliderValue = min(max(0, value.location.x / geometry.size.width), 1)
                                    let newTime = sliderValue * duration
                                    onSliderChange(newTime)
                                }
                    )

               
                Rectangle()
                    .foregroundColor(Color.white.opacity(0.3))
                    .frame(height: 4)
                    .cornerRadius(2)
                
             
                Rectangle()
                    .foregroundColor(.blue)
                    .frame(width: CGFloat((currentTime / duration) * Double(geometry.size.width)), height: 4)
                    .cornerRadius(2)
            }
            .frame(height: 30)
        }
    }
}
