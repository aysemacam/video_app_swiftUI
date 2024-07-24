//
//  VideoPlayerView.swift
//  video_player_app_SwiftUI
//
//  Created by Aysema Çam on 23.07.2024.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    let video: Video
    @State private var player: AVPlayer
    @State private var isLandscape: Bool = false
    @State private var isPlaying: Bool = true
    @State private var isLocked: Bool = false
    @State private var currentTime: Double = 0
    @State private var duration: Double = 0
    @State private var selectedSpeed: Float = 1
    @State private var showUnlockButton: Bool = false

    init(video: Video) {
        self.video = video
        self._player = State(initialValue: AVPlayer(url: URL(string: video.videos.small.url)!))
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VideoPlayer(player: player)
                    .onAppear {
                        player.play()
                        player.rate = selectedSpeed
                        addPeriodicTimeObserver()
                        addBoundaryTimeObserver()
                    }
                    .onDisappear {
                        player.pause()
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .edgesIgnoringSafeArea(isLandscape ? .all : .horizontal)
                
                Color.black.opacity(0.01)
                    .contentShape(Rectangle())

                if !isLocked {
                    VStack {
                        PlayerTopView(title: video.user)
                            .padding(15)
                            .frame(height: 50)
                            .background(Color.clear)
                            .zIndex(1)

                        Spacer()
                        
                        OverlayButtonsView(selectedSpeed: $selectedSpeed, isLandscape: $isLandscape, player: player)
                            .background(Color.clear)
                            .zIndex(1)

                        VStack {
                            CustomSliderView(currentTime: $currentTime, duration: $duration)
                                .padding(.horizontal)
                                .frame(height: 30)
                                .background(Color.clear)
                            
                            HStack {
                                LockButton(isLocked: $isLocked)
                                PreviousButton(player: player)
                                PlayPauseButton(isPlaying: $isPlaying, player: player, selectedSpeed: $selectedSpeed)
                                NextButton(player: player)
                                EmptyButton()
                            }
                            .frame(height: 30)
                            .background(Color.clear)
                        }
                        .padding(.vertical)
                        .zIndex(1)
                    }
                }

                if showUnlockButton {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
                                isLocked = false
                                showUnlockButton = false
                            }) {
                                Image(systemName: "lock.fill")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Circle().fill(Color.black.opacity(0.7)))
                            }
                            .padding(.bottom)
                            Spacer()
                        }
                    }
                    .transition(.opacity)
                    .animation(.easeInOut)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation {
                                showUnlockButton = false
                            }
                        }
                    }
                    .zIndex(2)
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                if isLocked {
                    withAnimation {
                        showUnlockButton = true
                    }
                }
            }
        }
        .onRotate { newOrientation in
            isLandscape = newOrientation.isLandscape
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .background(Color.black)
    }

    private func addPeriodicTimeObserver() {
        let interval = CMTime(seconds: 0.1, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { time in
            self.currentTime = CMTimeGetSeconds(time)
            if let duration = player.currentItem?.duration {
                self.duration = CMTimeGetSeconds(duration)
            }
        }
    }

    private func addBoundaryTimeObserver() {
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
            self.isPlaying = false
            self.player.seek(to: CMTime.zero)
            self.currentTime = 0
            self.player.pause()
        }
    }
}

struct LockButton: View {
    @Binding var isLocked: Bool

    var body: some View {
        Button(action: {
            isLocked.toggle()
        }) {
            Image(systemName: isLocked ? "lock.fill" : "lock.open.fill")
                .foregroundColor(.white)
                .padding()
                .background(Circle().fill(Color.black.opacity(0.7)))
        }
    }
}

struct UnlockOverlayView: View {
    @Binding var isLocked: Bool

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    isLocked.toggle()
                }) {
                    Image(systemName: "lock.fill")
                        .foregroundColor(.white)
                        .padding()
                        .background(Circle().fill(Color.black.opacity(0.7)))
                }
                .padding(.bottom)
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.clear)
        .contentShape(Rectangle())
    }
}

struct EmptyButton: View {
    var body: some View {
        Button(action: {}) {
            Image(systemName: "rectangle.inset.filled.and.cursorarrow")
                .foregroundColor(.white)
                .padding()
                .background(Circle().fill(Color.black.opacity(0.7)))
        }
    }
}
