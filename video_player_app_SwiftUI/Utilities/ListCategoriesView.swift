//
//  ListCategoriesView.swift
//  video_player_app_SwiftUI
//
//  Created by Aysema Çam on 23.07.2024.
//
import SwiftUI
import AVKit

import SwiftUI

struct ListCategoriesView: View {
    let items: [Category]
    @Binding var selectedItem: Category?
    @Binding var currentVideoIndex: Int
    @Binding var player: AVPlayer
    var viewModel: VideoViewModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(items) { item in
                    HStack {
                        Image(systemName: item.imageName)
                            .resizable()
                            .frame(width: 15, height: 15)
                        Text(item.title)
                            .font(.caption)
                    }
                    .padding(10)
                    .background(selectedItem?.id == item.id ? Color.red.opacity(0.2) : Color.gray.opacity(0.1))
                    .cornerRadius(7)
                    .onTapGesture {
                        selectedItem = item
                        if let index = viewModel.customItems.firstIndex(where: { $0.id == item.id }) {
                            currentVideoIndex = index
                            viewModel.fetchVideos(query: item.title)
                            if let videoUrl = viewModel.videos.first?.videos.small.url {
                                player.replaceCurrentItem(with: AVPlayerItem(url: URL(string: videoUrl)!))
                                player.play()
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}
