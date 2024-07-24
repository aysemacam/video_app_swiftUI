//
//  PreviousNextButtons.swift
//  video_player_app_SwiftUI
//
//  Created by Aysema Çam on 24.07.2024.
//

import SwiftUI
import AVKit

struct PreviousButton: View {
    var player: AVPlayer

    var body: some View {
        Button(action: {
        
        }) {
            Image(systemName: "backward.end.fill")
                .foregroundColor(.white)
                .padding()
                .background(Circle().fill(Color.black.opacity(0.7)))
        }
        .padding(15)
    }
}

struct NextButton: View {
    var player: AVPlayer

    var body: some View {
        Button(action: {
          
        }) {
            Image(systemName: "forward.end.fill")
                .foregroundColor(.white)
                .padding()
                .background(Circle().fill(Color.black.opacity(0.7)))
        }
        .padding(15)
    }
}
