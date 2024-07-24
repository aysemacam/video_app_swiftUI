//
//  PlayerButtonsView.swift
//  video_player_app_SwiftUI
//
//  Created by Aysema Çam on 23.07.2024.
//

import SwiftUI
import AVKit

struct OverlayButtonsView: View {
    @State private var showSpeedOptions = false
    @Binding var selectedSpeed: Float
    @Binding var isLandscape: Bool
    @State private var offsetValue: CGFloat = -240
    @State private var isCollapsed: Bool = false
    var player: AVPlayer

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    print("Settings button tapped")
                }) {
                    Image(systemName: "gearshape")
                        .resizable()
                        .frame(width: 17, height: 17)
                        .padding(10)
                        .background(Color.buttonsBack.opacity(0.7))
                        .clipShape(Circle())
                        .foregroundColor(.white)
                }
                .frame(width: 40, height: 40)

                GeometryReader { geometry in
                    ZStack(alignment: .top) {
                        Button(action: {
                            withAnimation {
                                showSpeedOptions.toggle()
                            }
                        }) {
                            Text("\(Int(selectedSpeed))x")
                                .padding(0)
                                .font(.footnote)
                                .frame(width: 38, height: 38)
                                .background(Color.buttonsBack.opacity(0.7))
                                .clipShape(Circle())
                                .foregroundColor(.white)
                        }
                        .background(Color.clear)
                        .frame(width: 40, height: 40)

                        if showSpeedOptions {
                            VStack(spacing: 10) {
                                Button(action: {
                                    selectedSpeed = 1.0
                                    player.rate = selectedSpeed
                                    showSpeedOptions = false
                                }) {
                                    Text("1x")
                                        .frame(width: 60, height: 10)
                                        .padding(5)
                                        .foregroundColor(.white)
                                        .background(Color.gray.opacity(0.5))
                                        .cornerRadius(5)
                                }
                                
                                Button(action: {
                                    selectedSpeed = 2.0
                                    player.rate = selectedSpeed
                                    showSpeedOptions = false
                                }) {
                                    Text("2x")
                                        .frame(width: 60, height: 10)
                                        .padding(5)
                                        .background(Color.gray.opacity(0.5))
                                        .cornerRadius(5)
                                        .foregroundColor(.white)

                                }
                                
                                Button(action: {
                                    selectedSpeed = 3.0
                                    player.rate = selectedSpeed
                                    showSpeedOptions = false
                                }) {
                                    Text("3x")
                                        .frame(width: 60, height: 10)
                                        .padding(5)
                                        .background(Color.gray.opacity(0.5))
                                        .cornerRadius(5)
                                        .foregroundColor(.white)
                                }
                            }
                            .frame(width: 60, height: 50)
                            .background(Color.clear)
                            .position(x: geometry.frame(in: .global).midX - 50, y: geometry.frame(in: .global).minY + 45)
                        }
                    }
                }
                .frame(width: 40, height: 40)

                Button(action: {
                    isLandscape.toggle()
                }) {
                    Image(systemName: "iphone")
                        .frame(width: 17, height: 17)
                        .padding(10)
                        .background(Color.buttonsBack.opacity(0.7))
                        .clipShape(Circle())
                        .foregroundColor(.white)
                }
                .frame(width: 40, height: 40)
                .background(
                    OrientationChanger(orientation: isLandscape ? .landscapeRight : .portrait)
                )

                Button(action: {
                    print("Favorite button tapped")
                }) {
                    Image(systemName: "pencil")
                        .resizable()
                        .frame(width: 17, height: 17)
                        .padding(10)
                        .background(Color.buttonsBack.opacity(0.7))
                        .clipShape(Circle())
                        .foregroundColor(.white)
                }
                .frame(width: 40, height: 40)

                Button(action: {
                    print("Download button tapped")
                }) {
                    Image(systemName: "airpodsmax")
                        .frame(width: 17, height: 17)
                        .padding(10)
                        .background(Color.buttonsBack.opacity(0.7))
                        .clipShape(Circle())
                        .foregroundColor(.white)
                }
                .frame(width: 40, height: 40)
                
                Button(action: {
                    withAnimation {
                        offsetValue = offsetValue == 0 ? -230 : 0
                        isCollapsed.toggle()
                    }
                }) {
                    Image(systemName: isCollapsed ? "arrow.left" : "arrow.right")
                        .frame(width: 12, height: 12)
                        .padding(8)
                        .background(Color.buttonsBack.opacity(0.7))
                        .clipShape(Circle())
                        .foregroundColor(.white)
                }
                .frame(width: 40, height: 40)
                Spacer()
            }
            .offset(x: offsetValue)
            Spacer()
        }
    }
}

#Preview {
    OverlayButtonsView(selectedSpeed: .constant(1), isLandscape: .constant(false), player: AVPlayer())
}
