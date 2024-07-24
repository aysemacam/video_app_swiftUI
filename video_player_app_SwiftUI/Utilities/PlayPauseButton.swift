//
//  PlayPauseButton.swift
//  video_player_app_SwiftUI
//
//  Created by Aysema Çam on 24.07.2024.
//

import SwiftUI
import AVKit

struct PlayPauseButton: View {
    @Binding var isPlaying: Bool
    var player: AVPlayer
    @Binding var selectedSpeed: Float
    
    var body: some View {
        Button(action: {
            isPlaying.toggle()
            if isPlaying {
                player.play()
                player.rate = selectedSpeed
            } else {
                player.pause()
            }
        }) {
            Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                .resizable()
                .foregroundColor(.white)
                .frame(width: 20, height: 20)
                .padding()
                .background(Circle().fill(Color.black.opacity(0.7)))
        }
        .padding(15)
    }
}
