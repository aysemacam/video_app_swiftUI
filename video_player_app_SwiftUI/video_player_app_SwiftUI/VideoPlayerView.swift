//
//  VideoPlayerView.swift
//  video_player_app_SwiftUI
//
//  Created by Aysema Çam on 23.07.2024.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    let videos: [Video]
    @State private var player: AVPlayer
    @State private var isLandscape: Bool = false
    @State private var isPlaying: Bool = true
    @State private var isLocked: Bool = false
    @State private var currentTime: Double = 0
    @State private var duration: Double = 0
    @State private var selectedSpeed: Float = 1
    @State private var showUnlockButton: Bool = false
    @State private var currentVideoIndex: Int

    init(videos: [Video], currentVideoIndex: Int = 0) {
        self.videos = videos
        self._currentVideoIndex = State(initialValue: currentVideoIndex)
        self._player = State(initialValue: AVPlayer(url: URL(string: videos[currentVideoIndex].videos.small.url)!))
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                CustomVideoPlayer(player: player, isLandscape: isLandscape)
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
                    .ignoresSafeArea()
           
                    

                Color.black.opacity(0.01)
                    .contentShape(Rectangle())

                if !isLocked {
                    VStack {
                        PlayerTopView(title: videos[currentVideoIndex].user)
                            .padding(.horizontal, 15)
                        
                            .frame(height: 30)
                            .background(Color.clear)
                            .zIndex(1)

                        OverlayButtonsView(selectedSpeed: $selectedSpeed, isLandscape: $isLandscape, player: player)
                            .background(Color.clear)
                            .frame(height: 40)
                            .zIndex(1)
                        Spacer()

                        VStack {
                            CustomSliderView(currentTime: $currentTime, duration: $duration) { newTime in
                                currentTime = newTime
                                let seekTime = CMTime(seconds: currentTime, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
                                player.seek(to: seekTime)
                            }
                                .padding(.horizontal)
                                .frame(height: 30)
                                .background(Color.clear)
                              

                            HStack {
                                LockButton(isLocked: $isLocked)
                                PreviousButton(currentVideoIndex: $currentVideoIndex, videos: videos, player: $player, addPeriodicTimeObserver: addPeriodicTimeObserver, addBoundaryTimeObserver: addBoundaryTimeObserver, isPlaying: $isPlaying)
                                PlayPauseButton(isPlaying: $isPlaying, player: player, selectedSpeed: $selectedSpeed)
                                NextButton(currentVideoIndex: $currentVideoIndex, videos: videos, index: selectedSpeed, player: $player, addPeriodicTimeObserver: addPeriodicTimeObserver, addBoundaryTimeObserver: addBoundaryTimeObserver, isPlaying: $isPlaying)
                                EmptyButton()
                            }
                            .frame(height: 30)
                            .background(Color.clear)
                        }
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                    }
                    .frame(maxHeight: .infinity)
                    .background(Color.clear)
                    .ignoresSafeArea()
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
                    .zIndex(1)
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
        .ignoresSafeArea()
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

struct CustomVideoPlayer: UIViewControllerRepresentable {
    var player: AVPlayer
    var isLandscape: Bool

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        controller.videoGravity = isLandscape ? .resizeAspectFill : .resizeAspect
        return controller
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        uiViewController.videoGravity = isLandscape ? .resizeAspectFill : .resizeAspect
        if isLandscape {
            DispatchQueue.main.async {
                uiViewController.view.transform = .identity
                uiViewController.view.frame = UIScreen.main.bounds
            }
        } else {
            DispatchQueue.main.async {
                uiViewController.view.transform = .identity
                uiViewController.view.frame = UIScreen.main.bounds
            }
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
