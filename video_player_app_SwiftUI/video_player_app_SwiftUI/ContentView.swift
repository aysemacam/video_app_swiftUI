//
//  ContentView.swift
//  video_player_app_SwiftUI
//
//  Created by Aysema Çam on 23.07.2024.
//

import SwiftUI
import AVKit

struct ContentView: View {
    @StateObject var viewModel = VideoViewModel()
    @State private var selectedItem: Category? = nil

    var body: some View {
        NavigationView {
            VStack {
                ListTopView()
    
                
                ListCategoriesView(items: viewModel.customItems, selectedItem: $selectedItem)
                    .onAppear {
                        selectedItem = viewModel.customItems.first
                        if let firstItem = viewModel.customItems.first {
                            viewModel.fetchVideos(query: firstItem.title)
                        }
                    }
                    .padding(.vertical)

                List(viewModel.videos) { video in
                    NavigationLink(destination: VideoPlayerView(video: video)) {
                        ListContentView(
                            title: video.user,
                            subtitle: video.tags,
                            imageUrl: video.videos.small.thumbnail
                        )
                        .listRowSeparator(.hidden)
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .background(Color.red)
        .edgesIgnoringSafeArea(.all)
        .onChange(of: selectedItem) { newValue in
            if let newValue = newValue {
                viewModel.fetchVideos(query: newValue.title)
            }
        }
    }
}