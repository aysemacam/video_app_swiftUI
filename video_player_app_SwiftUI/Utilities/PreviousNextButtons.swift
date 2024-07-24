//
//  PreviousNextButtons.swift
//  video_player_app_SwiftUI
//
//  Created by Aysema Çam on 24.07.2024.
//

import SwiftUI
import AVKit

struct PreviousButton: View {
    @Binding var currentVideoIndex: Int
    var videos: [Video]
    @Binding var player: AVPlayer
    var addPeriodicTimeObserver: () -> Void
    var addBoundaryTimeObserver: () -> Void
    @Binding var isPlaying: Bool

    var body: some View {
        Button(action: {
            if currentVideoIndex > 0 {
                currentVideoIndex -= 1
                player.replaceCurrentItem(with: AVPlayerItem(url: URL(string: videos[currentVideoIndex].videos.small.url)!))
                player.seek(to: CMTime.zero)
                player.play()
                isPlaying = true
                addPeriodicTimeObserver()
                addBoundaryTimeObserver()
            }
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
    @Binding var currentVideoIndex: Int
    var videos: [Video]
    var index: Float = 1
    @Binding var player: AVPlayer
    var addPeriodicTimeObserver: () -> Void
    var addBoundaryTimeObserver: () -> Void
    @Binding var isPlaying: Bool

    var body: some View {
        Button(action: {
            if currentVideoIndex < videos.count - 1 {
                currentVideoIndex += 1
                player.replaceCurrentItem(with: AVPlayerItem(url: URL(string: videos[currentVideoIndex].videos.small.url)!))
                player.seek(to: CMTime.zero)
                player.play()
                player.rate = index
                isPlaying = true
                addPeriodicTimeObserver()
                addBoundaryTimeObserver()
            }
        }) {
            Image(systemName: "forward.end.fill")
                .foregroundColor(.white)
                .padding()
                .background(Circle().fill(Color.black.opacity(0.7)))
        }
        .padding(15)
    }
}
